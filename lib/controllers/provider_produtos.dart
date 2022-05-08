import 'package:flutter/material.dart';
import 'package:garagem_burger/controllers/firebase.dart';
import 'package:garagem_burger/models/produto.dart';

class ProviderProdutos with ChangeNotifier {
  final List<Produto> _products = [];

  Future<void> loadProducts() async {
    final futureSnapshot = Firebase.getFirestore().collection('produtos').get();
    futureSnapshot.then((snapshot) {
      snapshot.docs.asMap().forEach((_, doc) {
        final productData = doc.data();
        _products.add(
          Produto(
            id: doc.id,
            nome: productData['nome'],
            preco: productData['preco'] * 1.0,
            tipo: productData['tipo'],
          ),
        );
      });
    });
  }

  List<Produto> get sobremesas {
    return productList.where((product) {
      return product.tipo == Produto.sobremesa;
    }).toList();
  }

  List<Produto> get acompanhamentos {
    return productList.where((product) {
      return product.tipo == Produto.acompanhamento;
    }).toList();
  }

  List<Produto> get bebidas {
    return productList.where((product) {
      return product.tipo == Produto.bebida;
    }).toList();
  }

  List<Produto> get hamburgueres {
    return productList.where((product) {
      return product.tipo == Produto.hamburguerCasa;
    }).toList();
  }

  List<Produto> get productList {
    return [..._products];
  }
}
