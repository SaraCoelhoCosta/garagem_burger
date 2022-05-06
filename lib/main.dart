// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:garagem_burger/components/auth_check.dart';
import 'package:garagem_burger/controllers/auth_service.dart';
import 'package:garagem_burger/pages/meus_lanches/tela_montar_hamburguer.dart';
import 'package:garagem_burger/providers/provider_carrinho.dart';
import 'package:garagem_burger/providers/provider_cartao.dart';
import 'package:garagem_burger/providers/provider_lanches.dart';
import 'package:garagem_burger/providers/provider_localizacoes.dart';
import 'package:garagem_burger/providers/provider_pedidos.dart';
import 'package:garagem_burger/providers/provider_produtos.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:garagem_burger/pages/start/tela_abertura.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:garagem_burger/pages/start/tela_cadastro_usuario.dart';
import 'package:garagem_burger/pages/start/tela_login.dart';
import 'package:garagem_burger/pages/tela_principal.dart';
import 'package:garagem_burger/pages/menu/tela_produto.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ProviderProdutos()),
        ChangeNotifierProvider(create: (_) => ProviderLanches()),
        ChangeNotifierProvider(create: (_) => ProviderPedidos()),
        ChangeNotifierProvider(create: (_) => ProviderLocalizacoes()),
        ChangeNotifierProvider(create: (_) => ProviderCarrinho()),
        ChangeNotifierProvider(create: (_) => ProviderCartao()),
      ],
      child: MaterialApp(
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
          backgroundColor: const Color(0xfffed80b),
        ),

        //home: AuthCheck(),
        initialRoute: Rotas.home,

        routes: {
          Rotas.home: (context) => TelaAbertura(),
          Rotas.authCheck: (context) => AuthCheck(),
          Rotas.login: (context) => TelaLogin(),
          Rotas.cadastro: (context) => TelaCadastroUsuario(),
          Rotas.main: (context) => TelaPrincipal(),
          Rotas.produto: (context) => TelaProduto(),
          Rotas.montarHamburguer: (context) => TelaMontarHamburguer(),
        },
      ),
    );
  }
}
