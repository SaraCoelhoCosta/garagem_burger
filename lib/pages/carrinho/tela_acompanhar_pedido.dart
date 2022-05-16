import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaAcompanharPedido extends StatelessWidget {
  const TelaAcompanharPedido({Key? key}) : super(key: key);

  @override
  String toStringShort() {
    return 'Acompanhar Pedido';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox.square(
            dimension: MediaQuery.of(context).size.width * 0.30,
            child: const CircularProgressIndicator(),
          ),
          Text(
            'Aguarde enquanto processamos seu pedido.',
            style: GoogleFonts.oxygen(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
