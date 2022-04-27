import 'package:flutter/material.dart';

class Rotas {
  static const home = '/';
  static const login = '/login';
  static const cadastro = '/cadastro';

  static const main = '/principal';

  static const montarHamburguer = '/montar-hamburguer';
  static const produto = '/produto';

  static void nvgComRetorno({
    required BuildContext context,
    required String rota,
    Object? argumentos,
  }) {
    Navigator.of(context).pushNamed(
      rota,
      arguments: argumentos,
    );
  }

  static void nvgSemRetorno({
    required BuildContext context,
    required String rota,
    Object? argumentos,
  }) {
    Navigator.of(context).pushReplacementNamed(
      rota,
      arguments: argumentos,
    );
  }
}
