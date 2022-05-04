import 'package:flutter/material.dart';
import 'package:garagem_burger/data/dados.dart';
import 'package:garagem_burger/models/cartao.dart';

class ProviderCartao with ChangeNotifier {
  final List<Cartao> _cartoes = cartoes;

  List<Cartao> get listaCartoes => [..._cartoes];

  int get qntCartoes => _cartoes.length;

  Cartao get cartaoPreferencial {
    return _cartoes.singleWhere((cartao) => cartao.favorite);
  }

  void selectFavorite(String idCartao) {
    for (Cartao cartao in _cartoes) {
      cartao.favorite = (cartao.id == idCartao);
    }

    notifyListeners();
  }

  void removeCartao(String idCartao) {
    bool alterarFavorito = false;

    if (cartaoPreferencial.id == idCartao && qntCartoes > 1) {
      alterarFavorito = true;
    }

    _cartoes.removeWhere((cartao) => cartao.id == idCartao);

    if (alterarFavorito) {
      _cartoes[0].favorite = true;
    }

    notifyListeners();
  }
}
