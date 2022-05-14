import 'package:flutter/material.dart';
import 'package:garagem_burger/data/dados.dart';
import 'package:garagem_burger/models/cartao.dart';

class ProviderCartao with ChangeNotifier {
  final List<Cartao> _cartoes = cartoes;

  List<Cartao> get listaCartoes => [..._cartoes];

  int get qntCartoes => _cartoes.length;

  bool get emptyList => _cartoes.isEmpty;

  Cartao get favoriteCard {
    return _cartoes.singleWhere((cartao) => cartao.favorite);
  }

  void selectFavorite(String id) {
    _cartoes.asMap().forEach((_, cartao) {
      cartao.favorite = (cartao.id == id);
    });
    notifyListeners();
  }

  void removeCartao(String id) {
    bool alterarFavorito = false;

    if (favoriteCard.id == id && qntCartoes > 1) {
      alterarFavorito = true;
    }

    _cartoes.removeWhere((cartao) => cartao.id == id);

    if (alterarFavorito) {
      _cartoes[0].favorite = true;
    }

    notifyListeners();
  }
}
