import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/combo_box.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/components/row_price.dart';
import 'package:garagem_burger/controllers/provider_pedidos.dart';
import 'package:garagem_burger/pages/carrinho/tela_pagamento.dart';
import 'package:garagem_burger/pages/localizacao/tela_nova_localizacao.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:garagem_burger/controllers/provider_localizacoes.dart';
import 'package:garagem_burger/utils/rotas.dart';
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
  bool isNewLocal = false;
  String? currentLocalId;
  double frete = 7.00;

  @override
  Widget build(BuildContext context) {
    final pvdLocal = Provider.of<ProviderLocalizacoes>(context);
    final pvdCarrinho = Provider.of<ProviderCarrinho>(context);
    final pvdPedido = Provider.of<ProviderPedidos>(context);
    if (!updatedLocal) {
      currentLocalId = (isNewLocal)
          ? pvdLocal.locations.keys.last
          : pvdLocal.favoriteLocation?.id;
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
                  //TODO: Diacho de comboBox não tá pegando as localizações já cadastradas
                  ComboBox(
                    value: currentLocalId,
                    items: pvdLocal.locations.values.map((local) {
                      return {
                        'id': local.id,
                        'descricao': local.descricao,
                      };
                    }).toList(),
                    onChanged: (String? selectedLocalId) {
                      setState(() {
                        currentLocalId = selectedLocalId!;
                      });
                    },
                  ),
                  const CustomText(
                    '\nSelecione um endereço cadastrado\n\nou',
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        Rotas.main,
                        arguments: {
                          'index': 2,
                          'page': const TelaNovaLocalizacao(),
                          'button': null,
                        },
                      ).then((isSubmit) {
                        if (isSubmit != null) {
                          isNewLocal = (isSubmit as bool);
                          updatedLocal = !isNewLocal;
                        }
                      });
                    },
                    child: const CustomText(
                      'Insira outro endereço',
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
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
                    onPressed: () {
                      if (currentLocalId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const CustomText(
                              'Selecione um endereço primeiro!',
                              textAlign: TextAlign.center,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            elevation: 6.0,
                            backgroundColor: Theme.of(context).errorColor,
                            duration: const Duration(milliseconds: 1500),
                          ),
                        );
                      } else {
                        pvdPedido.setEnderecoEntrega(currentLocalId!);
                        pvdPedido.setFrete(frete);
                        Navigator.of(context).pushNamed(
                          Rotas.main,
                          arguments: {
                            'index': 2,
                            'page': const TelaPagamento(),
                            'button': null,
                          },
                        );
                      }
                    },
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
