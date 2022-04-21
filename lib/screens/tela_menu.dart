import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaMenu extends StatefulWidget {
  const TelaMenu({Key? key}) : super(key: key);

  @override
  State<TelaMenu> createState() => _TelaMenuState();
}

class _TelaMenuState extends State<TelaMenu> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Menu',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    Text(
      'Carrinho',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    Text(
      'Perfil',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
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

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Perfil',
          ),
        ],
        
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xfffed80b),
        unselectedItemColor: Colors.white,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
