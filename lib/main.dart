// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:garagem_burger/screens/tela_abertura.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

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
      home: TelaAbertura(),
    );
  }
}

/* class MyHomePage extends StatefulWidget {
 *  const MyHomePage({Key? key}) : super(key: key);
 *
 *   @override
 *   State<MyHomePage> createState() => _MyHomePageState();
 * }
 *
 * class _MyHomePageState extends State<MyHomePage> {
 *  @override
 *   Widget build(BuildContext context) {
 *    return TelaAbertura();
 *   }
 * }
 */
