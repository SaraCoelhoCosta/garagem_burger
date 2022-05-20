import 'package:flutter/material.dart';
import 'package:garagem_burger/controllers/firebase.dart';
import 'package:garagem_burger/models/ingrediente.dart';
import 'package:garagem_burger/models/produto.dart';

class ProviderProdutos with ChangeNotifier {
  final List<Produto> _products = [];
  final List<Ingrediente> _ingredients = [];

  Future<void> loadProducts() async {
    _products.clear();
    final snapshot = await Firebase.getFirestore().collection('produtos').get();
    snapshot.docs.asMap().forEach((_, doc) {
      _products.add(
        Produto(
          id: doc.id,
          nome: doc.data()['nome'],
          preco: doc.data()['preco'] * 1.0,
          tipo: doc.data()['tipo'],
          urlImage: doc.data()['img'] ?? '',
          quantidade: 0,
          unidadeMedida: '',
        ),
      );
    });
    notifyListeners();
  }

  Future<void> loadIngredients() async {
    _ingredients.clear();
    final snapshot =
        await Firebase.getFirestore().collection('ingredientes').get();
    snapshot.docs.asMap().forEach((_, doc) {
      _ingredients.add(
        Ingrediente(
          id: doc.id,
          nome: doc.data()['nome'],
          preco: doc.data()['preco'] * 1.0,
          tipo: doc.data()['tipo'],
          quantidade: doc.data()['quantidade'] as int,
          unidadeMedida: doc.data()['unidadeMedida'],
        ),
      );
    });
  }

  List<Ingrediente> get ingredientes {
    return [..._ingredients];
  }

  List<Produto> get produtos {
    return [..._products];
  }

  List<Produto> get sobremesas {
    return produtos.where((product) {
      return product.tipo == Produto.sobremesa;
    }).toList();
  }

  List<Produto> get acompanhamentos {
    return produtos.where((product) {
      return product.tipo == Produto.acompanhamento;
    }).toList();
  }

  List<Produto> get bebidas {
    return produtos.where((product) {
      return product.tipo == Produto.bebida;
    }).toList();
  }

  List<Produto> get hamburgueres {
    return produtos.where((product) {
      return product.tipo == Produto.hamburguerCasa;
    }).toList();
  }
}
