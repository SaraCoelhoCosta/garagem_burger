// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garagem_burger/controllers/firebase.dart';
import 'package:garagem_burger/models/hamburguer.dart';
import 'package:garagem_burger/models/ingrediente.dart';
import 'package:garagem_burger/models/produto.dart';

class ProviderProdutos with ChangeNotifier {
  final List<Produto> _products = [];
  final List<Ingrediente> _ingredients = [];
  final List<Hamburguer> _hamburgers = [];

  Future<void> loadHamburgers() async {
    _hamburgers.clear();
    final snapshot = await Firebase.getFirestore()
        .collection('produtos')
        .where('tipo', isEqualTo: Produto.hamburguerCasa)
        .get();
    snapshot.docs.asMap().forEach((_, doc) {
      _hamburgers.add(
        Hamburguer(
          id: doc.id,
          nome: doc.data()['nome'],
          preco: double.parse(doc.data()['preco'].toString()),
          urlImage: doc.data()['img'] ?? '',
          quantidade: doc.data()['quantidade'],
          ingredientes: (doc.data()['ingredientes'] == null)
              ? []
              : (doc.data()['ingredientes'] as List<dynamic>)
                  .map((ingrediente) {
                  return {
                    'id': (ingrediente['id']
                            as DocumentReference<Map<String, dynamic>>)
                        .id,
                    'quantidade': ingrediente['quantidade'],
                  };
                }).toList(),
        ),
      );
    });
    print('${hamburgueres.length} hambúrgueres carregados.');
    notifyListeners();
  }

  Future<void> loadProducts() async {
    _products.clear();
    final snapshot = await Firebase.getFirestore().collection('produtos').where(
      'tipo',
      whereNotIn: [Produto.hamburguerCasa, Produto.combo],
    ).get();
    snapshot.docs.asMap().forEach((_, doc) {
      _products.add(
        Produto(
          id: doc.id,
          nome: doc.data()['nome'],
          preco: double.parse(doc.data()['preco'].toString()),
          tipo: doc.data()['tipo'],
          urlImage: doc.data()['img'] ?? '',
          quantidade: doc.data()['quantidade'],
          unidadeMedida: doc.data()['unidadeMedida'],
          recipiente: doc.data()['recipiente'],
        ),
      );
    });
    print('${bebidas.length} bebidas carregados.');
    print('${acompanhamentos.length} acompanhamentos carregados.');
    print('${sobremesas.length} sobremesas carregadas.');
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
          preco: double.parse(doc.data()['preco'].toString()),
          tipo: doc.data()['tipo'],
          quantidade: doc.data()['quantidade'],
          unidadeMedida: doc.data()['unidadeMedida'],
          urlImage: doc.data()['img'] ?? '',
        ),
      );
    });
    print('${ingredientes.length} ingredientes carregados.');
    notifyListeners();
  }

  List<Ingrediente> get ingredientes {
    return [..._ingredients];
  }

  List<Hamburguer> get hamburgueres {
    return [..._hamburgers];
  }

  List<Produto> get sobremesas {
    return _products.where((product) {
      return product.tipo == Produto.sobremesa;
    }).toList();
  }

  List<Produto> get acompanhamentos {
    return _products.where((product) {
      return product.tipo == Produto.acompanhamento;
    }).toList();
  }

  List<Produto> get bebidas {
    return _products.where((product) {
      return product.tipo == Produto.bebida;
    }).toList();
  }

  Ingrediente ingredientById(String id) {
    return _ingredients.singleWhere(
      (ingrediente) => ingrediente.id == id,
      orElse: () => _ingredients.first,
    );
  }

  Produto productById(String id) {
    return _products.singleWhere(
      (produto) => produto.id == id,
      orElse: () => _products.first,
    );
  }

  Hamburguer hamburguerById(String id) {
    return _hamburgers.singleWhere(
      (hamburguer) => hamburguer.id == id,
      orElse: () => _hamburgers.first,
    );
  }
}
