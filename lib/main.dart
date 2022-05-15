// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/pages/auth/tela_abertura.dart';
import 'package:garagem_burger/pages/auth/tela_cadastro_usuario.dart';
import 'package:garagem_burger/pages/auth/tela_login.dart';
import 'package:garagem_burger/pages/meus_lanches/tela_montar_hamburguer.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:garagem_burger/controllers/provider_cartao.dart';
import 'package:garagem_burger/controllers/provider_lanches.dart';
import 'package:garagem_burger/controllers/provider_localizacoes.dart';
import 'package:garagem_burger/controllers/provider_pedidos.dart';
import 'package:garagem_burger/controllers/provider_produtos.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:garagem_burger/pages/tela_principal.dart';
import 'package:garagem_burger/pages/menu/tela_produto.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  bool isAndroidOrIOS;
  try {
    isAndroidOrIOS = Platform.isAndroid || Platform.isIOS;
  } catch (e) {
    isAndroidOrIOS = false;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: (isAndroidOrIOS) ? null : DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderUsuario()),
        ChangeNotifierProvider(create: (_) => ProviderProdutos()),
        ChangeNotifierProvider(create: (_) => ProviderLanches()),
        ChangeNotifierProvider(create: (_) => ProviderPedidos()),
        ChangeNotifierProvider(create: (_) => ProviderCarrinho()),
        ChangeNotifierProvider(create: (_) => ProviderCartao()),
        ChangeNotifierProvider(create: (_) => ProviderLocalizacoes()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // O app só vai funcionar na orientação retrato
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: const Color(0xfffed80b),
        // textTheme: TextTheme(),
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
