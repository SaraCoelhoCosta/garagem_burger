import 'package:flutter/material.dart';

class Rotas {
  static const abertura = '/';
  static const menu = '/menu';
  static const meusLanches = '/meus-lanches';
  static const perfil = '/perfil';
  static const carrinho = '/carrinho';
  static const configuracoes = '/configuracoes';
  static const meusCartoes = '/meus-cartoes';
  static const meusPedidos = '/meus-pedidos';
  static const minhasLocalizacoes = '/minhas-localizacoes';
  static const login = '/login';
  static const cadastro = '/cadastro';
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
