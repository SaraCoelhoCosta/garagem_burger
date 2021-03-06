import 'package:flutter/material.dart';
import 'package:garagem_burger/controllers/provider_pedidos.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:garagem_burger/components/card_pedido.dart';
import 'package:garagem_burger/pages/menu/tela_menu.dart';
import 'package:garagem_burger/pages/tela_vazia.dart';
import 'package:provider/provider.dart';

class TelaMeusPedidos extends StatelessWidget {
  const TelaMeusPedidos({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Meus Pedidos';

  @override
  Widget build(BuildContext context) {
    final pvdPedido = Provider.of<ProviderPedidos>(context);
    if (pvdPedido.qntPedidos == 0) {
      return TelaVazia(
        pageName: 'Meus Pedidos',
        icon: Icons.content_paste,
        titulo: 'IR PARA O MENU',
        subtitulo: 'Você ainda não fez nenhum pedido.',
        rodape: 'Encontre o produto que deseja no Menu.',
        navigator: () => Navigator.of(context).pushNamedAndRemoveUntil(
          Rotas.main,
          (_) => false,
          arguments: {
            'index': 0,
            'page': const TelaMenu(),
            'button': null,
          },
        ),
      );
    } else {
      return ListView(
        children: [
          Column(
            children: pvdPedido.pedidos.values.map((pedido) {
              return CardPedido(pedido);
            }).toList(),
          ),
        ],
      );
    }
  }
}
