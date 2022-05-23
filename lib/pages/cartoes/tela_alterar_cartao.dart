import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/components/custom_text_field.dart';
import 'package:garagem_burger/controllers/provider_cartoes.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/models/cartao.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

enum CardType {
  credito,
  debito,
}

class TelaAlterarCartao extends StatefulWidget {
  final Cartao cartao;
  const TelaAlterarCartao(
    this.cartao, {
    Key? key,
  }) : super(key: key);

  @override
  String toStringShort() => 'Alterar cartão';

  @override
  State<TelaAlterarCartao> createState() => _TelaAlterarCartaoState();
}

class _TelaAlterarCartaoState extends State<TelaAlterarCartao> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
  var mascaraNumeroCartao = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  var mascaraVencimentoCartao = MaskTextInputFormatter(
    mask: '##/##',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  var mascaraCVV = MaskTextInputFormatter(
    mask: '####',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

// Campos de texto.
  final _descricao = TextEditingController();
  final _nomeTitular = TextEditingController();
  final _numeroCartao = TextEditingController();
  final _cvv = TextEditingController();
  final _vencimentoCartao = TextEditingController();

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

    _descricao.text = widget.cartao.descricao;
    _nomeTitular.text = widget.cartao.nomeTitular;
    _numeroCartao.text = widget.cartao.numeroCartao;
    _cvv.text = widget.cartao.cvv;
    _vencimentoCartao.text = widget.cartao.dataVencimento;
    _card = widget.cartao.tipo == "Crédito" ? CardType.credito : CardType.debito;
    super.initState();
  }

  Future<void> alterarCartao(BuildContext context) async {
    final user = Provider.of<ProviderUsuario>(
      context,
      listen: false,
    ).usuario;
    try {
      await context
          .read<ProviderCartoes>()
          .updateCartao(user, widget.cartao)
          .then((_) {
        Navigator.of(context).pop(true);
      });
    } on Exception catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomText('Erro ao alterar cartão'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 6.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child: Column(
              children: [
                CreditCardWidget(
                  labelCardHolder: 'NOME DO TITULAR',
                  labelExpiredDate: 'MM/AA',
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
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        labelText: 'Descrição',
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_campoNumeroCartao);
                        },
                        textInputAction: TextInputAction.next,
                        controller: _descricao,
                        validator: (String? value) {
                          if (value!.trim().isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
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
                          if (value!.trim().isEmpty) {
                            return 'Campo obrigatório';
                          } else if (value.trim().length < 16) {
                            return 'Número de cartão inválido';
                          }
                          return null;
                        },
                        controller: _numeroCartao,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: CustomTextField(
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
                                if (value!.trim().isEmpty) {
                                  return 'Campo obrigatório';
                                }
                                final DateTime now = DateTime.now();
                                final List<String> date =
                                    value.split(RegExp(r'/'));
                                final int month = int.parse(date.first);
                                final int year = int.parse('20${date.last}');
                                final DateTime cardDate =
                                    DateTime(year, month);
    
                                if (cardDate.isBefore(now) ||
                                    month > 12 ||
                                    month == 0) {
                                  return 'Data inválida';
                                }
                                return null;
                              }),
                              controller: _vencimentoCartao,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: CustomTextField(
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
                                if (value!.trim().isEmpty) {
                                  return 'Campo obrigatório';
                                } else if (value.trim().length < 3) {
                                  return 'Código inválido';
                                }
                                return null;
                              },
                              controller: _cvv,
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        labelText: 'Nome do titular',
                        focusNode: _campoNomeTitular,
                        onFieldSubmitted: (_) {
                          onCreditCardModelChange(creditCardModel);
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: _nomeTitular,
                        validator: (String? value) {
                          if (value!.trim().isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      Row(
                        // TODO: Verificar se retorna valor correto do RadioListTile.
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: RadioListTile<CardType>(
                              title: const CustomText('Crédito'),
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
                              title: const CustomText('Débito'),
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
                        labelText: 'Alterar cartão',
                        onPressed: () => {
                          if (_formKey.currentState!.validate())
                            {
                              widget.cartao.dataVencimento =
                                  _vencimentoCartao.text,
                              widget.cartao.nomeTitular = _nomeTitular.text,
                              widget.cartao.numeroCartao = _numeroCartao.text,
                              widget.cartao.cvv = _cvv.text,
                              widget.cartao.descricao = _descricao.text,
                              widget.cartao.tipo = _card == CardType.credito
                                  ? 'Crédito'
                                  : 'Débito',
                              alterarCartao(context),
                            }
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const CustomText(
                          'Cancelar',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
