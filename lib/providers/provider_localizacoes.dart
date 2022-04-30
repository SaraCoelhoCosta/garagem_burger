import 'package:flutter/material.dart';
import 'package:garagem_burger/data/dados.dart';
import 'package:garagem_burger/models/localizacao.dart';

class ProviderLocalizacoes with ChangeNotifier {

  final List<Localizacao> _localizacoes = localizacoes;

  List<Localizacao> get listaLocalizacoes => [..._localizacoes];

  int get qntLocalizacoes => _localizacoes.length;

  void removeLocalizacao(String idLocalizacao){
    _localizacoes.removeWhere((localizacao) => localizacao.id == idLocalizacao);
    notifyListeners();
  }
}