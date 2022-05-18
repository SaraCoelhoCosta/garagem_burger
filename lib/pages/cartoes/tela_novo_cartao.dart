// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/campo_texto.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum CardType {
  credito,
  debito,
}

class TelaNovoCartao extends StatefulWidget {
  const TelaNovoCartao({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Novo cartão';

  @override
  State<TelaNovoCartao> createState() => _TelaNovoCartaoState();
}

class _TelaNovoCartaoState extends State<TelaNovoCartao> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late CreditCardModel creditCardModel;
  CardType? _card = CardType.credito;
  String numeroCartao = '';
  String vencimentoCartao = '';
  String nomeTitular = '';
  String cvv = '';

  // Campos que estão com foco.
  final _campoNomeTitular = FocusNode();
  final _campoNumeroCartao = FocusNode();
  final _campoVencimentoCartao = FocusNode();
  final _campoCVV = FocusNode();

  // Máscara.
  var mascaraNumeroCartao = new MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  var mascaraVencimentoCartao = new MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  var mascaraCVV = new MaskTextInputFormatter(
    mask: '####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

// Campos de texto.
  final _descricao = TextEditingController();
  final _nomeTitular = TextEditingController();
  final _numeroCartao = TextEditingController();
  final _cvv = TextEditingController();
  final _vencimentoCartao = TextEditingController();

  bool _loading = false;
  bool isCvvFocused = false;

  Map<String, dynamic>? dadosCartao;

  // Libera os recursos após sair da tela ou salvar os dados.
  @override
  void dispose() {
    super.dispose();
    _campoNomeTitular.dispose();
    _campoNumeroCartao.dispose();
    _campoVencimentoCartao.dispose();
    _campoCVV.dispose();
  }

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = _campoCVV.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    numeroCartao = _numeroCartao.text;
    vencimentoCartao = _vencimentoCartao.text;
    nomeTitular = _nomeTitular.text;
    cvv = _cvv.text;

    creditCardModel = CreditCardModel(
      numeroCartao,
      vencimentoCartao,
      nomeTitular,
      cvv,
      isCvvFocused,
    );
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    _campoCVV.addListener(textFieldFocusDidChange);

    _numeroCartao.addListener(() {
      setState(() {
        numeroCartao = _numeroCartao.text;
        creditCardModel.cardNumber = numeroCartao;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _vencimentoCartao.addListener(() {
      setState(() {
        vencimentoCartao = _vencimentoCartao.text;
        creditCardModel.expiryDate = vencimentoCartao;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _nomeTitular.addListener(() {
      setState(() {
        nomeTitular = _nomeTitular.text;
        creditCardModel.cardHolderName = nomeTitular;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cvv.addListener(() {
      setState(() {
        cvv = _cvv.text;
        creditCardModel.cvvCode = cvv;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 6.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Novo cartão",
                        // Fonte do Google.
                        style: GoogleFonts.oxygen(
                          fontSize: 20, // Tamanho da fonte.
                          fontWeight: FontWeight.bold, // Largura da fonte.
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      CreditCardWidget(
                        labelCardHolder: "NOME DO TITULAR",
                        labelExpiredDate: "MM/AA",
                        cardNumber: numeroCartao,
                        expiryDate: vencimentoCartao,
                        cardHolderName: nomeTitular,
                        cvvCode: cvv,
                        showBackView: isCvvFocused,
                        obscureCardNumber: true,
                        obscureCardCvv: true,
                        isHolderNameVisible: true,
                        cardBgColor: Colors.black,
                        onCreditCardWidgetChange:
                            (CreditCardBrand creditCardBrand) {},
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            CampoTexto(
                              obscureText: false,
                              labelText: "Descrição",
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_campoNumeroCartao);
                              },
                              textInputAction: TextInputAction.next,
                              controller: _descricao,
                            ),
                            CampoTexto(
                              obscureText: false,
                              labelText: 'Número do cartão',
                              focusNode: _campoNumeroCartao,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_campoVencimentoCartao);
                              },
                              inputFormatters: [mascaraNumeroCartao],
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              validator: (String? value) {
                                if (value!.isEmpty || value.length < 16) {
                                  return "Número de cartão inválido";
                                }
                                return null;
                              },
                              controller: _numeroCartao,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: CampoTexto(
                                    obscureText: false,
                                    labelText: 'Vencimento',
                                    focusNode: _campoVencimentoCartao,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_campoCVV);
                                    },
                                    inputFormatters: [mascaraVencimentoCartao],
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    validator: ((String? value) {
                                      if (value!.isEmpty) {
                                        return "Campo de vencimento obrigatório";
                                      }
                                      final DateTime now = DateTime.now();
                                      final List<String> date =
                                          value.split(RegExp(r'/'));
                                      final int month = int.parse(date.first);
                                      final int year =
                                          int.parse('20${date.last}');
                                      final DateTime cardDate =
                                          DateTime(year, month);

                                      if (cardDate.isBefore(now) ||
                                          month > 12 ||
                                          month == 0) {
                                        return "Data inválida";
                                      }
                                      return null;
                                    }),
                                    controller: _vencimentoCartao,
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: CampoTexto(
                                    obscureText: true,
                                    labelText: 'CVV',
                                    focusNode: _campoCVV,
                                    inputFormatters: [mascaraCVV],
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_campoNomeTitular);
                                    },
                                    onChanged: (String text) {
                                      setState(() {
                                        cvv = text;
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    validator: (String? value) {
                                      if (value!.isEmpty || value.length < 3) {
                                        return 'Código inválido';
                                      }
                                      return null;
                                    },
                                    controller: _cvv,
                                  ),
                                ),
                              ],
                            ),
                            CampoTexto(
                              obscureText: false,
                              labelText: 'Nome do titular',
                              focusNode: _campoNomeTitular,
                              onFieldSubmitted: (_) {
                                onCreditCardModelChange(creditCardModel);
                              },
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              controller: _nomeTitular,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: RadioListTile<CardType>(
                                    title: const Text('Crédito'),
                                    value: CardType.credito,
                                    groupValue: _card,
                                    onChanged: (CardType? value) {
                                      setState(() {
                                        _card = value;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: RadioListTile<CardType>(
                                    title: const Text('Débito'),
                                    value: CardType.debito,
                                    groupValue: _card,
                                    onChanged: (CardType? value) {
                                      setState(() {
                                        _card = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Botao(
                              labelText: "Cadastrar cartão",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  // ignore: avoid_print
                                  print('Válido!');
                                } else {
                                  // ignore: avoid_print
                                  print('Inválido!');
                                }
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Cancelar",
                                // Fonte do Google.
                                style: GoogleFonts.oxygen(
                                  fontSize: 15, // Tamanho da fonte.
                                  //fontWeight: FontWeight.bold, // Largura da fonte.
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      numeroCartao = creditCardModel!.cardNumber;
      vencimentoCartao = creditCardModel.expiryDate;
      nomeTitular = creditCardModel.cardHolderName;
      cvv = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
