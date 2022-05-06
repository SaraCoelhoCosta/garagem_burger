import 'package:flutter/material.dart';
import 'package:garagem_burger/data/dados.dart';
import 'package:garagem_burger/models/localizacao.dart';

class ProviderLocalizacoes with ChangeNotifier {
  final List<Localizacao> _localizacoes = localizacoes;

  List<Localizacao> get listaLocalizacoes => [..._localizacoes];

  int get qntLocalizacoes => _localizacoes.length;

  bool get emptyList => _localizacoes.isEmpty;

  Localizacao get localizacaoPreferencial {
    return _localizacoes.singleWhere((local) => local.favorite);
  }

  void selectFavorite(String idLocal) {
    for (Localizacao local in _localizacoes) {
      local.favorite = (local.id == idLocal);
    }

    notifyListeners();
  }

  void removeLocalizacao(String idLocal) {
    bool alterarFavorito = false;

    if (localizacaoPreferencial.id == idLocal && qntLocalizacoes > 1) {
      alterarFavorito = true;
    }

    _localizacoes.removeWhere((local) => local.id == idLocal);

    if (alterarFavorito) {
      _localizacoes[0].favorite = true;
    }

    notifyListeners();
  }

}
