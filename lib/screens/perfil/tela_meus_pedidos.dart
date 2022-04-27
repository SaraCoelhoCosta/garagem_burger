import 'package:flutter/material.dart';
import 'package:garagem_burger/rotas.dart';
import 'package:garagem_burger/screens/components/card_pedido.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaMeusPedidos extends StatelessWidget {
  final bool telaVazia;

  const TelaMeusPedidos({Key? key, this.telaVazia = true}) : super(key: key);

  @override
  String toStringShort() => 'Meus Pedidos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffed80b),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Meus Pedidos',
          style: GoogleFonts.keaniaOne(
            fontSize: 26.0,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  Rotas.nvgSemRetorno(
                    context: context,
                    rota: Rotas.telaVazia,
                    argumentos: {
                      'page': 'Meus Pedidos',
                      'rota': Rotas.menu,
                      'icon': Icons.content_paste,
                      'titulo': 'IR PARA O MENU',
                      'subtitulo': 'Você ainda não fez nenhum pedido.',
                      'rodape': 'Encontre o produto que deseja no Menu.',
                    },
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
      ),
    );
  }
}
