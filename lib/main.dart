import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garagem_burger/controllers/cart.dart';
import 'package:garagem_burger/controllers/pages.dart';
import 'package:garagem_burger/controllers/products.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:garagem_burger/pages/main_page.dart';
import 'package:garagem_burger/pages/opening_page.dart';
import 'package:garagem_burger/pages/product_detail_page.dart';
import 'package:garagem_burger/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:garagem_burger/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (_) {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // O app só vai funcionar na orientação retrato
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Pages()),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        title: 'Garagem Burger',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: const Color(0xfffed80b),
        ),
        routes: {
          Routes.home: (context) => const OpeningPage(),
          Routes.main: (context) => const MainPage(),
          Routes.product: (context) => const ProductDetailPage(),
        },
      ),
    );
  }
}
