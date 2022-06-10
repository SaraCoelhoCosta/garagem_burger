import 'package:flutter/material.dart';
import 'package:garagem_burger/models/item_carrinho.dart';
import 'package:garagem_burger/models/produto.dart';

class Cart with ChangeNotifier {
  final Map<String, ItemCarrinho> _itens = {};

  Map<String, ItemCarrinho> get itensCarrinho => {..._itens};

  int get qntItens => _itens.length;

  bool get emptyList => _itens.isEmpty;

  double get precoTotal {
    double total = 0.0;
    _itens.forEach((_, itemCarrinho) {
      total += itemCarrinho.produto.preco * itemCarrinho.quantidade;
    });
    return total;
  }

  void addItemCarrinho(Produto produto, int quantidade) {
    // Item ja esta no carrinho
    if (_itens.containsKey(produto.id)) {
      _itens.update(
        produto.id,
        (itemCarrinho) => ItemCarrinho(
          id: produto.id,
          produto: itemCarrinho.produto,
          quantidade: itemCarrinho.quantidade + quantidade,
        ),
      );
    }

    // Item nao esta no carrinho
    else {
      _itens.putIfAbsent(
        produto.id,
        () => ItemCarrinho(
          id: produto.id,
          produto: produto,
          quantidade: quantidade,
        ),
      );
    }
    notifyListeners();
  }

  void editarItemCarrinho(Produto produto, int quantidade) {
    if (_itens.containsKey(produto.id)) {
      _itens.update(
        produto.id,
        (itemCarrinho) => ItemCarrinho(
          id: produto.id,
          produto: produto,
          quantidade: quantidade,
        ),
      );
    }

    notifyListeners();
  }

  void removeItemCarrinho(String idProduto) {
    _itens.remove(idProduto);
    notifyListeners();
  }

  void clearAll() {
    _itens.clear();
    notifyListeners();
  }
}
