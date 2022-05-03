import 'package:flutter/material.dart';
import 'package:garagem_burger/data/dados.dart';
import 'package:garagem_burger/models/cartao.dart';

class ProviderCartao with ChangeNotifier {
  final List<Cartao> _cartoes = cartoes;

  List<Cartao> get listaCartoes => [..._cartoes];

  int get qntCartoes => _cartoes.length;

  void selectFavorite(Cartao card) {
    for (Cartao cartao in _cartoes) {
      cartao.favorite = false;
    }

    _cartoes[_cartoes.indexOf(card)].favorite = true;

    notifyListeners();
  }

  void removeCartao(Cartao card) {
    bool alterarFavorito = false;

    if (_cartoes[_cartoes.indexOf(card)].favorite && qntCartoes > 1) {
      alterarFavorito = true;
    }

    _cartoes.removeWhere((cartao) => cartao.id == card.id);

    if (alterarFavorito) {
      _cartoes[0].favorite = true;
    }

    notifyListeners();
  }
}
