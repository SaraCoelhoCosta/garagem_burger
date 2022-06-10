import 'package:flutter/material.dart';
import 'package:garagem_burger/pages/cart_page.dart';
import 'package:garagem_burger/pages/lunch_page.dart';
import 'package:garagem_burger/pages/menu_page.dart';
import 'package:garagem_burger/pages/profile_page.dart';

class Pages with ChangeNotifier {
  int? currentIndex;
  Widget? currentPage;

  List<Widget> initialPages = const [
    MenuPage(),
    LunchPage(),
    CartPage(),
    ProfilePage(),
  ];

  setCurrentIndex(int index) {
    currentIndex = index;
    currentPage = initialPages[index];
    notifyListeners();
  }

  setCurrentPage(Widget page) {
    currentPage = page;
    notifyListeners();
  }

  clear() {
    currentIndex = null;
    currentPage = null;
    notifyListeners();
  }
}
