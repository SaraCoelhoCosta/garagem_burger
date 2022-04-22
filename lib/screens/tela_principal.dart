import 'package:flutter/material.dart';
import 'package:garagem_burger/screens/tela_menu.dart';
import 'package:garagem_burger/screens/tela_perfil.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  int _indiceBarraInferior = 0;

  static const List<Widget> _widgets = <Widget>[
    TelaMenu(),
    Center(
      child: Text(
        'Carrinho',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
    TelaPerfil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffed80b),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Garagem Burguer',
          style: GoogleFonts.keaniaOne(
            fontSize: 26.0,
          ),
        ),
      ),

      body: _widgets.elementAt(_indiceBarraInferior),

      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.content_paste),
            label: 'Menu',
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
        
        backgroundColor: Colors.black,
        currentIndex: _indiceBarraInferior,
        selectedItemColor: const Color(0xfffed80b),
        unselectedItemColor: Colors.white,
        onTap: (index){
          setState(() {
            _indiceBarraInferior = index;
          });
        },
      ),
    );
  }
}
