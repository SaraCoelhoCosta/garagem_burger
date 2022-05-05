// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:garagem_burger/controllers/auth_service.dart';
import 'package:garagem_burger/pages/start/tela_login.dart';
import 'package:garagem_burger/pages/tela_principal.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

// Checa o usuário.
class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    // Verifica se BD está carregado.
    if (auth.isLoading) {
      return loading();
    }
    // Verifica se tem usuário logado.
    else if (auth.usuario == null) {
      return login();
    }
    // Se BD estiver carregado e usário estiver logado.
    else {
      return principal();
    }
  }

  // Exibe na tela símbolo de carregamento.
  loading() {
    return Scaffold(
      backgroundColor: const Color(0xfffed80b),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // Exibe na tela símbolo de carregamento.
  login() {
    return TelaLogin();
  }

  principal() {
    return TelaPrincipal();
  }
}
