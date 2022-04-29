import 'package:flutter/material.dart';
import 'package:garagem_burger/data/rotas.dart';
import 'package:garagem_burger/screens/components/card_pedido.dart';
import 'package:garagem_burger/screens/components/popup_dialog.dart';
import 'package:garagem_burger/screens/tela_menu.dart';
import 'package:garagem_burger/screens/tela_vazia.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaMeusPedidos extends StatefulWidget {

  const TelaMeusPedidos({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Meus Pedidos';

  @override
  State<TelaMeusPedidos> createState() => _TelaMeusPedidosState();
}

class _TelaMeusPedidosState extends State<TelaMeusPedidos> {

  bool emptyPage = false;

  void _switchBody(bool pageState) {
    setState(() {
      emptyPage = pageState;
    });
  }

  Future _excluirPedido(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return PopupDialog(
          titulo: 'Excluir pedido',
          descricao: 'Deseja excluir o histórico de pedidos?',
          onPressedYesOption: () {
            Navigator.of(context).pop();
            _switchBody(true);
          },
          onPressedNoOption: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Widget _buildTela(){
    return ListView(
      children: [
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
        const CardPedido(
          text: 'Pedido pendente em 24/04/2022',
          icon: Icons.error_outline,
          color: Color(0xfffed80b),
        ),
        const CardPedido(
          text: 'Pedido entregue em 25/04/2022',
          icon: Icons.check_circle_outline,
          color: Colors.green,
        ),
        const CardPedido(
          text: 'Pedido cancelado em 23/04/2022',
          icon: Icons.cancel_outlined,
          color: Colors.red,
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

    return (emptyPage) ? _buildTelaVazia() : _buildTela();
  }
}
