// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Botao extends StatelessWidget {
  final String labelText;
  dynamic Function() onPressed;

  Botao({
    required this.labelText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      // Botão.
      child: ElevatedButton(
        // Texto do botão.
        child: Text(
          labelText,

          // Estilo do texto do botão.
          // Fonte do Google.
          style: GoogleFonts.oxygen(
            color: Colors.white, // Cor da fonte.
            fontSize: 18, // Tamanho da fonte.
            fontWeight: FontWeight.bold, // Largura da fonte.
          ),
        ),

        // Estilo do botão.
        style: ElevatedButton.styleFrom(
          primary: Colors.black,

          // Arredonda as bordas do botão.
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),

          // Aumenta a altura do botão (?)
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
        ),

        // Ação que o botão realiza ao ser pressionado.
        onPressed: onPressed,
      ),
    );
  }
}
