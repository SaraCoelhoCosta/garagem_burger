// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:garagem_burger/rotas.dart';
import 'package:garagem_burger/screens/tela_abertura.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:garagem_burger/screens/tela_cadastro_usuario.dart';
import 'package:garagem_burger/screens/tela_carrinho.dart';
import 'package:garagem_burger/screens/tela_login.dart';
import 'package:garagem_burger/screens/tela_meus_lanches.dart';
import 'package:garagem_burger/screens/tela_principal.dart';
import 'package:garagem_burger/screens/tela_produto.dart';
import 'package:garagem_burger/screens/telas_perfil/tela_configuracoes.dart';
import 'package:garagem_burger/screens/telas_perfil/tela_meus_cartoes.dart';
import 'package:garagem_burger/screens/telas_perfil/tela_meus_pedidos.dart';
import 'package:garagem_burger/screens/telas_perfil/tela_minhas_localizacoes.dart';
import 'package:garagem_burger/screens/telas_perfil/tela_perfil.dart';
// import 'firebase_options.dart';

// Funcao principal.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Constroi a tela.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],

      title: 'Garagem Burger',

      // Tira simbolo de debug.
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      initialRoute: Rotas.abertura,

      routes: {
        Rotas.abertura: (context) => TelaAbertura(),
        Rotas.menu: (context) => TelaPrincipal(),
        Rotas.meusLanches: (context) => TelaMeusLanches(),
        Rotas.carrinho: (context) => TelaCarrinho(),
        Rotas.perfil: (context) => TelaPerfil(),
        Rotas.meusPedidos: (context) => TelaMeusPedidos(),
        Rotas.minhasLocalizacoes: (context) => TelaMinhasLocalizacoes(),
        Rotas.meusCartoes: (context) => TelaMeusCartoes(),
        Rotas.configuracoes: (context) => TelaConfiguracoes(),
        Rotas.login: (context) => TelaLogin(),
        Rotas.cadastro: (context) => TelaCadastroUsuario(),
        Rotas.produto: (context) => TelaProduto(),
      },
    );
  }
}
