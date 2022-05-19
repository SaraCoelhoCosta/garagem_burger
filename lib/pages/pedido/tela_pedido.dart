import 'package:flutter/material.dart';
import 'package:garagem_burger/components/order_status_row.dart';
import 'package:garagem_burger/controllers/provider_pedidos.dart';
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
  @override
  String toStringShort() => 'Acompanhar Pedido';

  _showOrderDetailPage(){
    
  }

  @override
  Widget build(BuildContext context) {
    final pedido = ModalRoute.of(context)!.settings.arguments as Pedido;
    final pvdPedido = Provider.of<ProviderPedidos>(context);
    // Altura total da tela, subtraindo a altura da appBar
    final appBar = AppBar(
      backgroundColor: const Color(0xfffed80b),
      foregroundColor: Colors.black,
      centerTitle: true,
      title: Text(
        toStringShort(),
        style: GoogleFonts.keaniaOne(
          fontSize: 26.0,
        ),
      ),
    );
    final totalHeight = MediaQuery.of(context).size.height;
    final appBarHeight =
        appBar.preferredSize.height + MediaQuery.of(context).padding.top;
    final availableHeight = totalHeight - appBarHeight;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   foregroundColor: Colors.black,
      //   centerTitle: true,
      //   elevation: 0,
      //   title: Text(
      //     toStringShort(),
      //     style: GoogleFonts.keaniaOne(
      //       fontSize: 30,
      //     ),
      //   ),
      // ),
      appBar: appBar,
      // body: Center(child: Text(pedido.total.toStringAsFixed(2))),

      body: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          height: availableHeight * 0.5,
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: pedido.etapas.length,
            itemBuilder: (ctx, i) => OrderStatusRow(
              date: pedido.etapas[i]['date'] as DateTime,
              isComplete: pedido.etapas[i]['isComplete'] as bool,
              indexStatus: i,
            ),
          ),
          // child: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     OrderStatusRow(
          //       date: DateTime.now(),
          //       isComplete: true,
          //       indexStatus: 0,
          //     ),
          //     OrderStatusRow(
          //       date: DateTime.now(),
          //       isComplete: true,
          //       indexStatus: 1,
          //     ),
          //     OrderStatusRow(
          //       date: DateTime.now(),
          //       isComplete: true,
          //       indexStatus: 2,
          //     ),
          //     OrderStatusRow(
          //       date: DateTime.now(),
          //       isComplete: true,
          //       indexStatus: 3,
          //     ),
          //     OrderStatusRow(
          //       date: DateTime.now(),
          //       isComplete: true,
          //       indexStatus: 4,
          //     ),
          //   ],
          // ),
        ),
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
