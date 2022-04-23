import 'package:flutter/material.dart';
import 'package:garagem_burger/screens/tela_carrinho.dart';
import 'package:garagem_burger/screens/tela_menu.dart';
import 'package:garagem_burger/screens/tela_meus_lanches.dart';
import 'package:garagem_burger/screens/telas_perfil/tela_perfil.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaPrincipal extends StatefulWidget {

  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  int indexWidget = 0;

  static const _widgets = [
    {'titulo': 'Menu', 'tela': TelaMenu()},
    {'titulo': 'Meus Lanches', 'tela': TelaMeusLanches()},
    {'titulo': 'Carrinho', 'tela': TelaCarrinho()},
    {'titulo': 'Perfil', 'tela': TelaPerfil()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffed80b),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          _widgets.elementAt(indexWidget)['titulo'].toString(),
          style: GoogleFonts.keaniaOne(
            fontSize: 26.0,
          ),
        ),
      ),

      body: _widgets.elementAt(indexWidget)['tela'] as Widget,

      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.content_paste),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Meus Lanches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp),
            label: 'Perfil',
          ),
        ],
        
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        currentIndex: indexWidget,
        selectedItemColor: const Color(0xfffed80b),
        unselectedItemColor: Colors.white,
        onTap: (index) {
          setState(() {
            indexWidget = index;
          });
        },
      ),
    );
  }
}
