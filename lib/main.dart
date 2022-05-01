// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:garagem_burger/pages/meus_lanches/tela_montar_hamburguer.dart';
import 'package:garagem_burger/pages/localizacao/tela_nova_localizacao.dart';
import 'package:garagem_burger/providers/provider_carrinho.dart';
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
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderProdutos()),
        ChangeNotifierProvider(create: (_) => ProviderLanches()),
        ChangeNotifierProvider(create: (_) => ProviderPedidos()),
        ChangeNotifierProvider(create: (_) => ProviderLocalizacoes()),
        ChangeNotifierProvider(create: (_) => ProviderCarrinho()),
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
          // colorScheme: ColorScheme.light(
          //   secondary: const Color(0xfffed80b),
          // ),
        ),
      
        initialRoute: Rotas.home,
      
        routes: {
          Rotas.home: (context) => TelaAbertura(),
          Rotas.login: (context) => TelaLogin(),
          Rotas.cadastro: (context) => TelaCadastroUsuario(),
      
          Rotas.main: (context) => TelaPrincipal(),
          
          Rotas.produto: (context) => TelaProduto(),
          Rotas.montarHamburguer: (context) => TelaMontarHamburguer(),
          Rotas.localizacoes: (context) => TelaNovaLocalizacao(),
        },
      ),
    );
  }
}
