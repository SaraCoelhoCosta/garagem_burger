import 'package:flutter/material.dart';

class Rotas {
  
  static const abertura = '/';
  static const menu = '/menu';
  static const configuracoes = '/configuracoes';
  static const meusCartoes = '/meus-cartoes';
  static const meusPedidos = '/meus-pedidos';
  static const minhasLocalizacoes = '/minhas-localizacoes';
  static const login = '/login';
  static const cadastro = '/cadastro';

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
