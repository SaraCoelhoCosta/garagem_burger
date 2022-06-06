import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/components/cart_icon.dart';
import 'package:garagem_burger/controllers/pages.dart';
import 'package:garagem_burger/pages/menu_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  _switchTab(int index, Pages pvdPages) {
    pvdPages.setCurrentIndex(index);
    pvdPages.setCurrentPage(const MenuPage());

    // Limpar as rotas anteriores
    // if (Navigator.of(context).canPop()) {
    //   Navigator.of(context).pushNamedAndRemoveUntil(
    //     Routes.main,
    //     (_) => false,
    //     arguments: {
    //       'index': currentIndex,
    //       'page': currentPage,
    //     },
    //   );
    // }
  }

  @override
  void initState() {
    // Index inicial
    Provider.of<Pages>(
      context,
      listen: false,
    ).setCurrentIndex(0);

    // Tela inicial
    Provider.of<Pages>(
      context,
      listen: false,
    ).setCurrentPage(const MenuPage());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pvdPages = Provider.of<Pages>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffed80b),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: CustomText(
          pvdPages.currentPage.toStringShort(),
          fontSize: 26.0,
          fontType: FontType.title,
        ),
      ),
      body: pvdPages.currentPage,
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
            activeIcon: CartIcon(
              value: 0,
              color: Color(0xfffed80b),
            ),
            icon: CartIcon(
              value: 0,
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
        currentIndex: pvdPages.currentIndex,
        selectedItemColor: const Color(0xfffed80b),
        unselectedItemColor: Colors.white,
        onTap: (index) => _switchTab(index, pvdPages),
      ),
    );
  }
}
