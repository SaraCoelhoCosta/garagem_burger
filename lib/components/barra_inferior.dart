import 'package:flutter/material.dart';
import 'package:garagem_burger/components/icone_carrinho.dart';

class BarraInferior extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const BarraInferior({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          activeIcon: IconeCarrinho(
            value: '2',
            child: Icon(Icons.shopping_cart_outlined),
            color: Color(0xfffed80b),
          ),
          icon: IconeCarrinho(
            value: '2',
            child: Icon(Icons.shopping_cart_outlined),
          ),
          label: 'Carrinho',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_sharp),
          label: 'Perfil',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xfffed80b),
      unselectedItemColor: Colors.white,
      onTap: (index) => onTap(index),
    );
  }
}
