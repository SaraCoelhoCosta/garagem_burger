// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garagem_burger/controllers/firebase.dart';
import 'package:garagem_burger/models/localizacao.dart';

class ProviderLocalizacoes with ChangeNotifier {
  final Map<String, Localizacao> _locations = {};
  late FirebaseFirestore firestore;

  ProviderLocalizacoes() {
    _startProvider();
  }

  _startProvider() async {
    await _startFirestore();
  }

  _startFirestore() {
    firestore = Firebase.getFirestore();
  }

  Map<String, Localizacao> get locations => {..._locations};

  int get countLocations => _locations.length;

  bool get emptyList => _locations.isEmpty;

  Localizacao? get favoriteLocation {
    if (!emptyList) {
      return _locations.values.singleWhere((local) => local.favorito);
    } else {
      return null;
    }
  }

  // Define a localização preferencial do usuário
  Future<void> changeFavorite(User? user, String id) async {
    final oldFavorite = favoriteLocation;

    // Atualiza na lista
    _locations[favoriteLocation!.id]!.favorito = false;
    _locations[id]!.favorito = true;
    notifyListeners();

    // Atualiza no bd
    await updateLocation(user, oldFavorite!);
    await updateLocation(user, favoriteLocation!);
  }

  // Carrega as localizações do usuário que estão no firebase
  Future<void> loadLocations(User? user) async {
    if (user != null) {
      _locations.clear();
      final snapshot = await Firebase.getFirestore()
          .collection('usuarios/${user.uid}/localizacoes')
          .get();
      snapshot.docs.asMap().forEach((_, doc) {
        _locations.putIfAbsent(
          doc.id,
          () => Localizacao.fromMap(doc.id, doc.data()),
        );
      });
      print('$countLocations localizações carregadas.');
      notifyListeners();
    }
  }

  // Adiciona uma nova localização
  Future<void> addLocation(User? user, Map<String, dynamic> localData) async {
    // Adiciona no bd
    final doc = await firestore
        .collection('usuarios/${user!.uid}/localizacoes')
        .add(localData);

    // Adiciona na lista
    _locations.putIfAbsent(
      doc.id,
      () => Localizacao.fromMap(doc.id, localData),
    );
    notifyListeners();
  }

  // Atualiza os dados da localização no bd
  Future<void> updateLocation(User? user, Localizacao local) async {
    await firestore
        .collection('usuarios/${user!.uid}/localizacoes')
        .doc(local.id)
        .update(local.toMap());
    notifyListeners();
  }

  // Remove uma localização
  Future<void> deleteLocation(User? user, String id) async {
    // Remove da lista e verifica se era um endereço preferencial
    final oldFavorite = favoriteLocation;
    _locations.remove(id);
    if (oldFavorite?.id == id && !emptyList) {
      _locations.values.first.favorito = true;
    }
    notifyListeners();

    // Remove do bd e atualiza o endereço preferencial
    await firestore
        .collection('usuarios/${user!.uid}/localizacoes')
        .doc(id)
        .delete();
    if (oldFavorite?.id == id && !emptyList) {
      await updateLocation(user, _locations.values.first);
    }
  }
}
