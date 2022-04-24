import 'package:flutter/material.dart';
import 'package:garagem_burger/screens/components/card_pedido.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaMeusPedidos extends StatelessWidget {
  final bool telaVazia;

  const TelaMeusPedidos({Key? key, this.telaVazia = false}) : super(key: key);

  Widget telaMeusPedidosVazia() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            const Icon(Icons.content_paste, size: 100),
            const SizedBox(height: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 100,
                  width: 300,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'IR PARA O MENU',
                      style: GoogleFonts.oxygen(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 80, bottom: 70, left: 50, right: 50),
                  child: Text(
                    'Você ainda não fez nenhum pedido.',
                    style: GoogleFonts.oxygen(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Text(
              'Encontre o produto que deseja no Menu.',
              style: GoogleFonts.oxygen(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20)
          ],
        ),
      ],
    );
  }

  Widget telaMeusPedidos() {
    return ListView(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () {},
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
      body: (telaVazia) ? telaMeusPedidosVazia() : telaMeusPedidos(),
    );
  }
}
