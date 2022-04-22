// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garagem_burger/screens/tela_login.dart';

class TelaAbertura extends StatefulWidget {
  @override
  _TelaAberturaState createState() => _TelaAberturaState();
}

class _TelaAberturaState extends State<TelaAbertura> {
  // Controi tela.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffed80b), // Cor de fundo.

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

  /* Realiza transicao de uma tela para outra (mudanca de estado).
   * Tempo de duração da transacao é de 2 seg.
   * Chama a tela de login.
   */
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TelaLogin(),
        ),
      );
    });
  }
}
