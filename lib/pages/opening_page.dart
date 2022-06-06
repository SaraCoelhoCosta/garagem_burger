import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garagem_burger/controllers/products.dart';
import 'package:garagem_burger/utils/routes.dart';
import 'package:provider/provider.dart';

class OpeningPage extends StatefulWidget {
  const OpeningPage({Key? key}) : super(key: key);

  @override
  _OpeningPageState createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage>
    with SingleTickerProviderStateMixin {
  // Animações
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 0.5),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.fastLinearToSlowEaseIn,
  ));

  bool loadedProducts = false;

  Future<void> loadAllProducts(BuildContext context) async {
    //Carrega os ingredientes do banco de dados
    await Provider.of<Products>(
      context,
      listen: false,
    ).loadIngredients();

    //Carrega os produtos do banco de dados
    await Provider.of<Products>(
      context,
      listen: false,
    ).loadProducts();

    //Carrega os hamburgueres do banco de dados
    await Provider.of<Products>(
      context,
      listen: false,
    ).loadHamburgers();

    //Carrega os combos do banco de dados
    await Provider.of<Products>(
      context,
      listen: false,
    ).loadCombos();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    loadAllProducts(context);

    Future.delayed(const Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.main,
        (_) => false,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffed80b),
      body: SlideTransition(
        position: _offsetAnimation,
        child: Center(
          child: Image.asset(
            'images/logo-garagem-burguer.png',
            height: 250,
            width: 250,
          ),
        ),
      ),
    );
  }
}
