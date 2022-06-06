import 'package:flutter/material.dart';

class Pages with ChangeNotifier {
  late int currentIndex;
  late Widget currentPage;

  setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  setCurrentPage(Widget page) {
    currentPage = page;
    notifyListeners();
  }
}
