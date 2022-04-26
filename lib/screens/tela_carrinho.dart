import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaCarrinho extends StatelessWidget {

  const TelaCarrinho({ Key? key }) : super(key: key);

  @override
  String toStringShort() => 'Carrinho';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Carrinho',
        style: GoogleFonts.oxygen(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}