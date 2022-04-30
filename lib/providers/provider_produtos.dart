import 'package:flutter/material.dart';
import 'package:garagem_burger/data/dados.dart';
import 'package:garagem_burger/models/produto.dart';

class ProviderProdutos with ChangeNotifier {

  final List<Produto> _produtos = produtos;

  List<Produto> get listaProdutos => [..._produtos];
}