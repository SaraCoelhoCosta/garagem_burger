// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:garagem_burger/data/rotas.dart';
import 'package:garagem_burger/screens/montar_hamburguer/tela_montar_hamburguer.dart';
import 'package:garagem_burger/screens/tela_abertura.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:garagem_burger/screens/tela_cadastro_usuario.dart';
import 'package:garagem_burger/screens/tela_login.dart';
import 'package:garagem_burger/screens/tela_principal.dart';
import 'package:garagem_burger/screens/tela_produto.dart';
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

      initialRoute: Rotas.home,

      routes: {
        Rotas.home: (context) => TelaAbertura(),
        Rotas.login: (context) => TelaLogin(),
        Rotas.cadastro: (context) => TelaCadastroUsuario(),

        Rotas.main: (context) => TelaPrincipal(),
        
        Rotas.produto: (context) => TelaProduto(),
        Rotas.montarHamburguer: (context) => TelaMontarHamburguer(),
      },
    );
  }
}
