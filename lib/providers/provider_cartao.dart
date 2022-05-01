import 'package:flutter/material.dart';
import 'package:garagem_burger/data/dados.dart';
import 'package:garagem_burger/models/cartao.dart';

class ProviderCartao with ChangeNotifier {

  final List<Cartao> _cartoes = cartoes;

  List<Cartao> get listaCartoes => [..._cartoes];

  int get qntCartoes => _cartoes.length;

  void removeCartao(String cardNumber){
    _cartoes.removeWhere((cartao) => cartao.cardNumber == cardNumber);
    notifyListeners();
  }
}
