// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garagem_burger/controllers/firebase.dart';
import 'package:garagem_burger/models/combo.dart';
import 'package:garagem_burger/models/hamburguer.dart';
import 'package:garagem_burger/models/ingrediente.dart';
import 'package:garagem_burger/models/produto.dart';

class ProviderProdutos with ChangeNotifier {
  final List<Produto> _products = [];
  final List<Ingrediente> _ingredients = [];
  final List<Hamburguer> _hamburgers = [];
  final List<Combo> _combos = [];

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
    print('${bebidas.length} bebidas carregadas.');
    print('${acompanhamentos.length} acompanhamentos carregados.');
    print('${sobremesas.length} sobremesas carregadas.');
    notifyListeners();
  }

  Future<void> loadCombos() async {
    _combos.clear();
    final snapshot = await Firebase.getFirestore()
        .collection('produtos')
        .where('tipo', isEqualTo: Produto.combo)
        .get();
    snapshot.docs.asMap().forEach((_, doc) {
      _combos.add(
        Combo(
          id: doc.id,
          nome: doc.data()['nome'],
          preco: double.parse(doc.data()['preco'].toString()),
          urlImage: doc.data()['img'] ?? '',
          itens: (doc.data()['itens'] as List<dynamic>).map((item) {
            return {
              'id': (item['id'] as DocumentReference<Map<String, dynamic>>).id,
              'quantidade': item['quantidade'],
            };
          }).toList(),
        ),
      );
    });
    print('${combos.length} combos carregados.');
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

  List<Combo> get combos {
    return [..._combos];
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

  List<Ingrediente> get paes {
    return _ingredients.where((ingrediente) {
      return ingrediente.tipo == Ingrediente.pao;
    }).toList();
  }

  List<Ingrediente> get carnes {
    return _ingredients.where((ingrediente) {
      return ingrediente.tipo == Ingrediente.carne;
    }).toList();
  }

  Ingrediente? ingredientById(String id) {
    try {
      return _ingredients.singleWhere((ingrediente) => ingrediente.id == id);
    } catch (_) {
      return null;
    }
  }

  Produto? productById(String id) {
    try {
      return _products.singleWhere((produto) => produto.id == id);
    } catch (_) {
      return null;
    }
  }

  Hamburguer? hamburguerById(String id) {
    try {
      return _hamburgers.singleWhere((hamburguer) => hamburguer.id == id);
    } catch (_) {
      return null;
    }
  }

  Hamburguer updateHamburguer(
    Hamburguer hamburguer,
    String idIng, {
    String? newId,
    int? qnt,
  }) {
    final updatedIng = hamburguer.ingredientes.map((ing) {
      // Trocar ingrediente
      if (newId != null && ing['id'] == idIng) {
        return {'id': newId, 'quantidade': ing['quantidade']};
      }
      // Alterar quantidade
      else if (qnt != null && ing['id'] == idIng) {
        return {'id': ing['id'], 'quantidade': qnt};
      }
      // Faz nada
      else {
        return {'id': ing['id'], 'quantidade': ing['quantidade']};
      }
    }).toList();

    return Hamburguer(
      ingredientes: updatedIng,
      id: hamburguer.id,
      nome: hamburguer.nome,
      preco: hamburguer.preco,
      urlImage: hamburguer.urlImage,
      quantidade: hamburguer.quantidade!,
    );
  }

  // Retorna o pao que tem nesse hamburguer
  String? hamburguerBread(String id) {
    final hamburguer = hamburguerById(id);
    if (hamburguer!.totalIngredientes > 0) {
      final pao = hamburguer.ingredientes.singleWhere((ingrediente) {
        final ing = ingredientById(ingrediente['id']);
        return ing?.tipo == Ingrediente.pao;
      });
      return pao['id'];
    } else {
      return null;
    }
  }

  // Retorna a carne e a quantidade que tem nesse hamburguer
  Map<String, dynamic>? hamburguerMeat(String id) {
    final hamburguer = hamburguerById(id);
    if (hamburguer!.totalIngredientes > 0) {
      return hamburguer.ingredientes.singleWhere((ingrediente) {
        final ing = ingredientById(ingrediente['id']);
        return ing?.tipo == Ingrediente.carne;
      });
    } else {
      return null;
    }
  }

  // Retorna os ingredientes, mas sem o pao e a carne
  List<Map<String, dynamic>?> ingHamburguer(Hamburguer hamburguer) {
    if (hamburguer.totalIngredientes > 0) {
      return hamburguer.ingredientes.map((ingrediente) {
        final ing = ingredientById(ingrediente['id']);
        if (ing?.tipo != Ingrediente.carne && ing?.tipo != Ingrediente.pao) {
          return {
            'id': ingrediente['id'],
            'quantidade': ingrediente['quantidade'],
          };
        }
      }).toList();
    } else {
      return [{}];
    }
  }
}
