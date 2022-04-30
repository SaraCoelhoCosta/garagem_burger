import 'package:flutter/material.dart';
import 'package:garagem_burger/providers/provider_pedidos.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:garagem_burger/components/card_pedido.dart';
import 'package:garagem_burger/components/popup_dialog.dart';
import 'package:garagem_burger/pages/menu/tela_menu.dart';
import 'package:garagem_burger/pages/tela_vazia.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TelaMeusPedidos extends StatelessWidget {
  const TelaMeusPedidos({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Meus Pedidos';

  Future _excluirPedido(context) {
    final provider = Provider.of<ProviderPedidos>(
      context,
      listen: false,
    );
    return showDialog(
      context: context,
      builder: (context) {
        return PopupDialog(
          titulo: 'Excluir pedido',
          descricao: 'Deseja excluir o histórico de pedidos?',
          onPressedYesOption: () {
            Navigator.of(context).pop();
            provider.clearAll();
          },
          onPressedNoOption: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Widget _buildTela(BuildContext context) {
    final provider = Provider.of<ProviderPedidos>(context);
    return ListView(
      children: [
        // const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () {
                Future.delayed(
                  const Duration(seconds: 0),
                  () => _excluirPedido(context),
                );
              },
              label: Text('Apagar histórico de pedidos',
                  style: GoogleFonts.oxygen(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.left),
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          ],
        ),
        // const SizedBox(height: 10),
        Column(
          children: provider.listaPedidos
              .map((pedido) => CardPedido(pedido: pedido))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTelaVazia() {
    return const TelaVazia(
      pageName: 'Meus Pedidos',
      icon: Icons.content_paste,
      rota: Rotas.main,
      titulo: 'IR PARA O MENU',
      subtitulo: 'Você ainda não fez nenhum pedido.',
      rodape: 'Encontre o produto que deseja no Menu.',
      argumentos: [0, TelaMenu()],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderPedidos>(context);
    return (provider.qntPedidos == 0) ? _buildTelaVazia() : _buildTela(context);
  }
}
