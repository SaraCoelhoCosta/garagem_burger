// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Tela extends StatefulWidget {
  @override
  _TelaAberturaState createState() => _TelaAberturaState();
}

class _TelaAberturaState extends State<Tela> {
  // Controi tela.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Cor de fundo.

      body: Center(
        // Imagem a ser usada.
        child: Image.asset(
          "./images/logoHamburgueria.png",
          height: 250,
          width: 250,
        ),
      ),
    );
  }
}
