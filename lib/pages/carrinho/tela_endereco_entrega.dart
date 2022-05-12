import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/row_price.dart';
import 'package:garagem_burger/models/localizacao.dart';
import 'package:garagem_burger/pages/carrinho/tela_pagamento.dart';
import 'package:garagem_burger/pages/localizacao/tela_nova_localizacao.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:garagem_burger/controllers/provider_localizacoes.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TelaEnderecoEntrega extends StatefulWidget {
  const TelaEnderecoEntrega({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Endereço de entrega';

  @override
  State<TelaEnderecoEntrega> createState() => _TelaEnderecoEntregaState();
}

class _TelaEnderecoEntregaState extends State<TelaEnderecoEntrega> {
  bool updatedLocal = false;
  Localizacao? currentLocal;
  double frete = 7.00;

  @override
  Widget build(BuildContext context) {
    final pvdLocal = Provider.of<ProviderLocalizacoes>(
      context,
      listen: false,
    );
    final pvdCarrinho = Provider.of<ProviderCarrinho>(
      context,
      listen: false,
    );
    if (!updatedLocal) {
      // TODO: currentLocal = pvdLocal.localizacaoPreferencial;
      updatedLocal = true;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
                      child: DropdownButton<Localizacao>(
                        menuMaxHeight: kMinInteractiveDimension * 3 + 10,
                        underline: Container(),
                        dropdownColor: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        value: currentLocal,
                        style: GoogleFonts.oxygen(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        items: [],
                        /*TODO: items: pvdLocal.listaLocalizacoes.map((local) {
                          return DropdownMenuItem<Localizacao>(
                            value: local,
                            child: Text(local.description!),
                          );
                        }).toList(),*/
                        onChanged: (Localizacao? selectedLocal) {
                          setState(() {
                            currentLocal = selectedLocal!;
                          });
                        },
                      ),
                    ),
                  ),
                  Text(
                    '\nSelecione um endereço cadastrado',
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
                        'page': const TelaNovaLocalizacao(),
                        'button': null,
                      },
                    ),
                    child: Text(
                      'Insira outro endereço',
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
              //     DropdownButton<Localizacao>(
              //       menuMaxHeight: kMinInteractiveDimension * 3,
              //       borderRadius: BorderRadius.circular(10),
              //       icon: const Icon(Icons.keyboard_arrow_down),
              //       // isExpanded: true,
              //       value: currentLocal,
              //       style: GoogleFonts.oxygen(
              //         fontSize: 17,
              //         fontWeight: FontWeight.normal,
              //         color: Colors.black,
              //       ),
              //       items: pvdLocal.listaLocalizacoes.map((local) {
              //         return DropdownMenuItem<Localizacao>(
              //           value: local,
              //           child: Text(local.description!),
              //         );
              //       }).toList(),
              //       onChanged: (Localizacao? selectedLocal) {
              //         setState(() {
              //           currentLocal = selectedLocal!;
              //         });
              //       },
              //     ),
              //     Text(
              //       '\nSelecione um endereço cadastrado',
              //       style: GoogleFonts.oxygen(
              //         fontSize: 17,
              //         fontWeight: FontWeight.normal,
              //         color: Colors.black,
              //       ),
              //     ),
              //     Text(
              //       '\nou',
              //       style: GoogleFonts.oxygen(
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
              //           'page': const TelaNovaLocalizacao(),
              //           'button': null,
              //         },
              //       ),
              //       child: Text(
              //         'Insira outro endereço',
              //         style: GoogleFonts.oxygen(
              //           fontSize: 17,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RowPrice(
                    text: 'Sub Total',
                    value: pvdCarrinho.precoTotal,
                  ),
                  RowPrice(
                    text: 'Frete',
                    value: frete,
                  ),
                  RowPrice(
                    text: 'Total',
                    value: pvdCarrinho.precoTotal + frete,
                  ),
                  Botao(
                    labelText: 'Confirmar',
                    externalPadding: const EdgeInsets.only(top: 10),
                    onPressed: () => Navigator.of(context).pushNamed(
                      Rotas.main,
                      arguments: {
                        'index': 3,
                        'page': const TelaPagamento(),
                        'button': null,
                      },
                    ),
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
