import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/row_price.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:garagem_burger/controllers/provider_cartao.dart';
import 'package:garagem_burger/models/cartao.dart';
import 'package:garagem_burger/pages/cartoes/tela_novo_cartao.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TelaPagamento extends StatefulWidget {
  const TelaPagamento({Key? key}) : super(key: key);

  @override
  State<TelaPagamento> createState() => _TelaPagamentoState();

  @override
  String toStringShort() => 'Pagamento';
}

class _TelaPagamentoState extends State<TelaPagamento> {
  bool isPix = false;
  bool updatedCard = false;
  Cartao? currentCard;

  @override
  Widget build(BuildContext context) {
    final pvdCarrinho = Provider.of<ProviderCarrinho>(
      context,
      listen: false,
    );
    final pvdCartao = Provider.of<ProviderCartao>(
      context,
      listen: false,
    );
    if (!updatedCard) {
      currentCard = pvdCartao.cartaoPreferencial;
      updatedCard = true;
    }
    return Column(
      children: [
        /*
        * Switch Pix ~ Cartão
        */
        Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /*
              * Botão PIX
              */
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() => isPix = true);
                    },
                    icon: const Icon(Icons.pix),
                    iconSize: 50,
                    color: (isPix) ? Colors.blue : Colors.black,
                  ),
                  Text(
                    'PIX',
                    style: GoogleFonts.oxygen(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: (isPix) ? Colors.blue : Colors.black,
                    ),
                  ),
                ],
              ),
              /*
              * Botão Cartão
              */
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() => isPix = false);
                    },
                    icon: const Icon(Icons.credit_card),
                    iconSize: 50,
                    color: (!isPix) ? Colors.blue : Colors.black,
                  ),
                  Text(
                    'Cartão',
                    style: GoogleFonts.oxygen(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: (!isPix) ? Colors.blue : Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        /*
        * Selecionar cartão
        */
        if (!isPix)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.only(left: 12, right: 8),
                        child: DropdownButton<Cartao>(
                          menuMaxHeight: kMinInteractiveDimension * 3 + 10,
                          underline: Container(),
                          dropdownColor: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          value: currentCard,
                          style: GoogleFonts.oxygen(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          items: pvdCartao.listaCartoes.map((cartao) {
                            return DropdownMenuItem<Cartao>(
                              value: cartao,
                              child: Text(cartao.description),
                            );
                          }).toList(),
                          onChanged: (Cartao? selectedCard) {
                            setState(() {
                              currentCard = selectedCard!;
                            });
                          },
                        ),
                      ),
                    ),
                    Text(
                      '\nSelecione um cartão cadastrado',
                      style: GoogleFonts.oxygen(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '\nou',
                      style: GoogleFonts.oxygen(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushNamed(
                        Rotas.main,
                        arguments: {
                          'index': 2,
                          'page': const TelaNovoCartao(),
                          'button': null,
                        },
                      ),
                      child: Text(
                        'Insira outro cartão',
                        style: GoogleFonts.oxygen(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                // child: Column(
                //   children: [
                //     DropdownButton<Cartao>(
                //       borderRadius: BorderRadius.circular(10),
                //       icon: const Icon(Icons.keyboard_arrow_down),
                //       isExpanded: true,
                //       value: currentCard,
                //       items: pvdCartao.listaCartoes.map((local) {
                //         return DropdownMenuItem<Cartao>(
                //           value: local,
                //           child: Text(
                //             local.description,
                //           ),
                //         );
                //       }).toList(),
                //       onChanged: (Cartao? selectedCard) {
                //         setState(() {
                //           currentCard = selectedCard!;
                //         });
                //       },
                //     ),
                //     const Text(
                //       '\nSelecione um cartão cadastrado',
                //       style: TextStyle(
                //         fontSize: 17,
                //         fontWeight: FontWeight.normal,
                //         color: Colors.black,
                //       ),
                //     ),
                //     const Text(
                //       'ou',
                //       style: TextStyle(
                //         fontSize: 17,
                //         fontWeight: FontWeight.normal,
                //         color: Colors.black,
                //       ),
                //     ),
                //     TextButton(
                //       onPressed: () => Navigator.of(context).pushNamed(
                //         Rotas.main,
                //         arguments: {
                //           'index': 2,
                //           'page': const TelaNovoCartao(),
                //           'button': null,
                //         },
                //       ),
                //       child: Text(
                //         'Insira outro cartão',
                //         style: GoogleFonts.oxygen(
                //           fontSize: 15,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.blue,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ),
          ),
        /*
        * Selecionar PIX
        */
        if (isPix)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(
                    'Pagamento - Chave PIX',
                    style: GoogleFonts.oxygen(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '95.752.445/0001-34',
                    style: GoogleFonts.oxygen(
                      fontSize: 18,
                    ),
                  ),
                  trailing: IconButton(
                    // TODO: Copiar o subtitle para a área de transferência
                    onPressed: () {},
                    icon: const Icon(Icons.copy),
                  ),
                ),
              ),
            ),
          ),
        /*
        * Total
        */
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RowPrice(
                    text: 'Total',
                    value: pvdCarrinho.precoTotal,
                  ),
                  Botao(
                    labelText: 'Confirmar',
                    externalPadding: const EdgeInsets.only(top: 10),
                    onPressed:
                        () {}, // TODO: Navegar para a tela de Acompanhar Pedido
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
