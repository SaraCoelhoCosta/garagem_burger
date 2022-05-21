// ignore_for_file: prefer_final_fields, prefer_void_to_null, unused_element

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:garagem_burger/controllers/firebase.dart';
import 'package:flutter/material.dart';
import 'package:garagem_burger/models/usuario.dart';

// Classe para exceções.
class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

// Classe para serviço do usuário (acesso).
class ProviderUsuario extends ChangeNotifier {
  // Firebase para autenticação e criação de usuário.
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = Firebase.getFirestore();
  FirebaseStorage storage = Firebase.getStorage();
  User? usuario;
  bool isLoading = true;

  ProviderUsuario() {
    _authCheck();
  }

  // Checa se tem usuário logado ou não.
  _authCheck() {
    // Muda estado do usuário.
    _auth.authStateChanges().listen((User? user) {
      usuario = user;
      isLoading = false;
      notifyListeners();
    });
  }

  // Retorna usuário atual.
  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  // Cadastra novo usuário no authentication.
  registrar(
      String email, String senha, Map<String, dynamic> dadosUsuario) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      await _auth.currentUser!
          .updateDisplayName(dadosUsuario['nome'].toString());
      _getUser();
      _salvarDados(dadosUsuario);
    } on FirebaseAuthException catch (e) {
      // Mensagens de erro.
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este e-mail já está cadastrado!');
      }
    }
  }

  // Salva os dados no firestore.
  Future<Null> _salvarDados(Map<String, dynamic> dadosUsuario) async {
    await firestore.collection("usuarios").doc(usuario!.uid).set(dadosUsuario);
  }

  // Realiza login do usuário.
  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      // Mensagem de erro.
      if (e.code == 'user-not-found') {
        throw AuthException('E-mail não encontrado. Cadastre-se!');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente!');
      }
    }
  }

  // Realiza o logout do usuário.
  logout() async {
    await _auth.signOut();
    _getUser();
  }

  // Atualiza os dados do usuário no BD
  Future<void> updateUsuario(User? user, Usuario usuario) async {
    await firestore
        .collection('usuarios')
        .doc(usuario.id)
        .update(usuario.toMap());
    await _auth.currentUser!.updateDisplayName(usuario.nome);
    _getUser();
  }

  // Remove usuário
  Future<void> deleteUsuario(User? user) async {
    // TODO: confirmar se remove do BD.
    await firestore.doc(user!.uid).delete();
    _getUser();
  }

  // Adicionar foto
  Future<void> addPhoto(User? user, String path) async {
    File file = File(path);
    try {
      String ref = 'Usuários/${user!.uid}/perfil.png';
      final task = await storage.ref(ref).putFile(file);
      await usuario!.updatePhotoURL(await task.ref.getDownloadURL());
      _getUser();
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload da foto: ${e.code}');
    }
  }

  /*esqueceuSenha(String email) async {
    try {
      await _auth.sendSignInLinkToEmail(
          email: email, actionCodeSettings: actionCodeSettings);
    } on FirebaseAuthException catch (e) {
      // Mensagem de erro.
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      }
    }
  }*/

  /*novaSenha(String senha) async{
    try {
      await _auth;
    } on FirebaseAuthException catch (e) {
      // Mensagem de erro.
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      }
    }
  }*/
}
