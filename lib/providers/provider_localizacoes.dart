import 'package:flutter/material.dart';
import 'package:garagem_burger/data/dados.dart';
import 'package:garagem_burger/models/localizacao.dart';

class ProviderLocalizacoes with ChangeNotifier {
  final List<Localizacao> _localizacoes = localizacoes;

  List<Localizacao> get listaLocalizacoes => [..._localizacoes];

  int get qntLocalizacoes => _localizacoes.length;

  void selectFavorite(Localizacao local) {
    for (Localizacao localizacao in _localizacoes) {
      localizacao.favorite = false;
    }

    _localizacoes[_localizacoes.indexOf(local)].favorite = true;

    notifyListeners();
  }

  void removeLocalizacao(Localizacao local) {
    bool alterarFavorito = false;
    if (_localizacoes[_localizacoes.indexOf(local)].favorite &&
        qntLocalizacoes > 1) {
      alterarFavorito = true;
    }

    _localizacoes.removeWhere((localizacao) => localizacao.id == local.id);

    if (alterarFavorito) {
      _localizacoes[0].favorite = true;
    }
    notifyListeners();
  }
}
