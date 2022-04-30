import 'package:flutter/material.dart';
import 'package:garagem_burger/data/dados.dart';
import 'package:garagem_burger/models/produto.dart';

class ProviderLanches with ChangeNotifier {

  List<Produto> _meusLanches = meusLanches;

  List<Produto> get listaLanches => [..._meusLanches];

  int get qntLanches => _meusLanches.length;

  void addLanche(Produto novoLanche){
    _meusLanches.add(novoLanche);
    notifyListeners();
  }

  void removeLanche(String idLanche){
    _meusLanches.removeWhere((lanche) => lanche.id == idLanche);
    notifyListeners();
  }

  void clearAll(){
    _meusLanches = [];
    notifyListeners();
  }
}