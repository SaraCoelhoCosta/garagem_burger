import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:garagem_burger/components/botao_amarelo.dart';
import 'package:garagem_burger/components/campo_texto.dart';
import 'package:google_fonts/google_fonts.dart';

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
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  CardType? _card = CardType.credito;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        showBackView: isCvvFocused,
                        obscureCardNumber: true,
                        obscureCardCvv: true,
                        isHolderNameVisible: true,
                        cardBgColor: Colors.black,
                        onCreditCardWidgetChange:
                            (CreditCardBrand creditCardBrand) {},
                      ),
                      CampoTexto(
                        obscureText: false,
                        labelText: "Descrição",
                      ),
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Colors.blue,
                        textColor: Colors.black,
                        cardNumberDecoration: const InputDecoration(
                          labelText: 'Número do cartão',
                        ),
                        expiryDateDecoration: const InputDecoration(
                          labelText: 'Vencimento',
                        ),
                        cvvCodeDecoration: const InputDecoration(
                          labelText: 'CVV',
                        ),
                        cardHolderDecoration: const InputDecoration(
                          labelText: 'Nome do titular',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
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
                      BotaoAmarelo(
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
        ),
      ],
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
