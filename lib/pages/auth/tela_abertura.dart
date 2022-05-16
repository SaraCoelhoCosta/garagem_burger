// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garagem_burger/controllers/provider_produtos.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaAbertura extends StatefulWidget {
  @override
  _TelaAberturaState createState() => _TelaAberturaState();
}

class _TelaAberturaState extends State<TelaAbertura>
    with SingleTickerProviderStateMixin {
  /* 
   * Realiza transicao de uma tela para outra (mudanca de estado).
   * Tempo de duração da transacao é de 2 seg.
   * Chama a tela de login.
   */

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

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    //Carrega os produtos do banco de dados
    Provider.of<ProviderProdutos>(
      context,
      listen: false,
    ).loadProducts().then((_) {
      print('Produtos carregados com sucesso!');
    });

    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Rotas.login,
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
      backgroundColor: Color(0xfffed80b),
      body: SlideTransition(
        position: _offsetAnimation,
        child: Hero(
          tag: 'logo',
          child: Center(
            child: Image.asset(
              "./images/logoHamburgueria.png",
              height: 250,
              width: 250,
            ),
          ),
        ),
      ),
    );
  }
}
