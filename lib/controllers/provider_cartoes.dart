import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garagem_burger/models/cartao.dart';
import 'package:garagem_burger/controllers/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderCartoes with ChangeNotifier {
  final Map<String, Cartao> _cartoes = {};
  late FirebaseFirestore firestore;

  ProviderCartoes() {
    _startProvider();
  }

  _startProvider() async {
    await _startFirestore();
  }

  _startFirestore() {
    firestore = Firebase.getFirestore();
  }

  Map<String, Cartao> get cartoes => {..._cartoes};

  bool get emptyList => _cartoes.isEmpty;

  Cartao? get favoriteCartao {
    if (!emptyList) {
      return _cartoes.values.singleWhere((cartao) => cartao.favorito);
    } else {
      return null;
    }
  }

  // Define o cartão preferencial do usuário
  Future<void> changeFavorite(User? user, String id) async {
    final oldFavorite = favoriteCartao;

    // Atualiza na lista
    _cartoes[favoriteCartao!.id]!.favorito = false;
    _cartoes[id]!.favorito = true;
    notifyListeners();

    // Atualiza no bd
    await updateCartao(user, oldFavorite!);
    await updateCartao(user, favoriteCartao!);
  }

  // Carrega os cartões do usuário que estão no firebase
  Future<void> loadCartoes(User? user) async {
    if (user != null) {
      _cartoes.clear();
      final snapshot = await Firebase.getFirestore()
          .collection('usuarios/${user.uid}/cartoes')
          .get();
      snapshot.docs.asMap().forEach((_, doc) {
        _cartoes.putIfAbsent(
      doc.id,
      () => Cartao.fromMap(doc.id, doc.data()),
    );
      });
      notifyListeners();
    }
  }

  // Adiciona um novo cartão
  Future<void> addCartao(User? user, Map<String, dynamic> cartaoData) async {
    // Adiciona no bd
    final doc = await firestore
        .collection('usuarios/${user!.uid}/cartoes')
        .add(cartaoData);

    // Adiciona na lista
    _cartoes.putIfAbsent(
      doc.id,
      () => Cartao.fromMap(doc.id, cartaoData),
    );
    notifyListeners();
  }

  // Atualiza os dados do cartão no bd
  Future<void> updateCartao(User? user, Cartao cartao) async {
    await firestore
        .collection('usuarios/${user!.uid}/cartoes')
        .doc(cartao.id)
        .update(cartao.toMap());
    notifyListeners();
  }

  // Remove um cartão
  Future<void> deleteCartao(User? user, String id) async {
    // Remove da lista e verifica se era um cartão preferencial
    final oldFavorite = favoriteCartao;
    _cartoes.remove(id);
    if (oldFavorite?.id == id && !emptyList) {
      _cartoes.values.first.favorito = true;
    }
    notifyListeners();

    // Remove do bd e atualiza o cartão preferencial
    await firestore
        .collection('usuarios/${user!.uid}/cartoes')
        .doc(id)
        .delete();
    if (oldFavorite?.id == id && !emptyList) {
      await updateCartao(user, _cartoes.values.first);
    }
  }
}
