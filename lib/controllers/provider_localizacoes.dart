// ignore_for_file: unnecessary_null_comparison, avoid_function_literals_in_foreach_calls, prefer_void_to_null, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garagem_burger/controllers/firebase.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/models/localizacao.dart';

class ProviderLocalizacoes with ChangeNotifier {
  final List<Localizacao> _localizacoes = [];
  late FirebaseFirestore firestore;
  late ProviderUsuario usuario;

  ProviderLocalizacoes({required this.usuario}) {
    _startProvider();
  }

  _startProvider() async {
    await _startFirestore();
    loadLocalizacoes();
  }

  _startFirestore() {
    firestore = Firebase.getFirestore();
  }

  loadLocalizacoes() async {
    if (usuario != null && _localizacoes.isEmpty) {
      final futureSnapshot = Firebase.getFirestore()
          .collection('usuarios/${usuario.usuario!.uid}/localizacoes')
          .get();

      futureSnapshot.then(
        (snapshot) {
          snapshot.docs.asMap().forEach(
            (_, doc) {
              final localizacaoData = doc.data();
              _localizacoes.add(
                Localizacao(
                  id: doc.id,
                  cep: localizacaoData['cep'],
                  rua: localizacaoData['rua'],
                  numero: localizacaoData['numero'],
                  bairro: localizacaoData['bairro'],
                  cidade: localizacaoData['cidade'],
                  estado: localizacaoData['estado'],
                  descricao: localizacaoData['descricao'],
                  favorito: localizacaoData['favorito'] ?? false,
                ),
              );
            },
          );
        },
      );
      notifyListeners();
    }
  }

  addFavorito(List<Localizacao> localizacoes) {
    // TODO: Fazer
  }

  addLocalizacao(Map<String, dynamic> dadosLocalizacao) {
    _salvarDados(dadosLocalizacao);
    loadLocalizacoes(); // TODO: não sei se é necessário.
  }

  // Salva os dados no firestore.
  Future<Null> _salvarDados(Map<String, dynamic> dadosLocalizacao) async {
    await firestore
        .collection('usuarios/${usuario.usuario!.uid}/localizacoes')
        .add(dadosLocalizacao);
  }

  editarLocalizacao(String id, Map<String, dynamic> dadosLocalizacao) async {
    await firestore
        .collection('usuarios/${usuario.usuario!.uid}/localizacoes')
        .doc(id)
        .update(dadosLocalizacao);
    loadLocalizacoes(); // TODO: não sei se é necessário.
    notifyListeners();
  }

  removerLocalizacao(Localizacao localizacao) async {
    await firestore
        .collection('usuarios/${usuario.usuario!.uid}/localizacoes')
        .doc(localizacao.id)
        .delete();
    _localizacoes.remove(localizacao);
    notifyListeners();
  }

  removerTodasLocalizacoes() async {
    _localizacoes.forEach((localizacao) async {
      await firestore
          .collection('usuarios/${usuario.usuario!.uid}/localizacoes')
          .doc(localizacao.id)
          .delete();
      _localizacoes.remove(localizacao);
    });
    notifyListeners();
  }

  List<Localizacao> get localizacoesList {
    return [..._localizacoes];
  }

  bool get listaVazia {
    return _localizacoes.isEmpty;
  }
}
