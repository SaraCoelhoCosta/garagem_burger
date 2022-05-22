import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/order_status_row.dart';
import 'package:garagem_burger/components/popup_dialog.dart';
import 'package:garagem_burger/controllers/provider_pedidos.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/models/pedido.dart';
import 'package:garagem_burger/pages/menu/tela_menu.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TelaPedido extends StatefulWidget {
  const TelaPedido({Key? key}) : super(key: key);

  @override
  State<TelaPedido> createState() => _TelaPedidoState();
}

class _TelaPedidoState extends State<TelaPedido> {
  bool canceling = false;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: const Color(0xfffed80b),
      foregroundColor: Colors.black,
      centerTitle: true,
      title: Text(
        'Acompanhar Pedido',
        style: GoogleFonts.keaniaOne(
          fontSize: 26.0,
        ),
      ),
    );

    // Dados das rotas e providers
    final pedido = ModalRoute.of(context)!.settings.arguments as Pedido;
    final pvdPedido = Provider.of<ProviderPedidos>(context);
    final user = Provider.of<ProviderUsuario>(context).usuario;

    // Altura disponível
    final totalHeight = MediaQuery.of(context).size.height;
    final appBarHeight =
        appBar.preferredSize.height + MediaQuery.of(context).padding.top;
    final availableHeight = totalHeight - appBarHeight;

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          /*
          * Etapas do pedido
          */
          Card(
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height: availableHeight * 0.5,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: pedido.etapas.map((etapa) {
                  return OrderStatusRow(
                    date: etapa['date'] as DateTime,
                    isComplete: etapa['isComplete'] as bool,
                    isCanceled: pedido.status == Pedido.cancelado,
                    indexStatus: pedido.etapas.indexOf(etapa),
                  );
                }).toList(),
              ),
            ),
          ),
          /*
          * Botão de cancelar
          */
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Botao(
              labelText: 'Cancelar',
              loading: canceling,
              externalPadding: const EdgeInsets.only(top: 20),
              onPressed: () => showDialog(
                context: context,
                builder: (ctx) => PopupDialog(
                  titulo: 'Tem certeza que deseja cancelar o pedido?',
                  yesLabel: 'Sim',
                  noLabel: 'Não',
                  onPressedYesOption: () => Navigator.of(ctx).pop(true),
                  onPressedNoOption: () => Navigator.of(ctx).pop(false),
                ),
              ).then((selectedYesOption) async {
                if (selectedYesOption) {
                  setState(() => canceling = true);
                  final canceled = await pvdPedido.cancelOrder(user, pedido);
                  if (canceled) {
                    // TODO: @Juao Mostrar para o usuário que isso aconteceu
                    print('O pedido foi cancelado!');
                  } else {
                    // TODO: @Juao Mostrar para o usuário que isso aconteceu
                    print('Não foi possível cancelar o pedido');
                  }
                  setState(() => canceling = false);
                }
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xfffed80b),
        child: const Icon(Icons.home_rounded),
        foregroundColor: Colors.black,
        onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
          Rotas.main,
          (_) => false,
          arguments: {
            'index': 0,
            'page': const TelaMenu(),
            'button': null,
          },
        ),
      ),
    );
  }
}
