// ignore_for_file: prefer_final_fields, prefer_void_to_null, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:garagem_burger/controllers/firebase.dart';
import 'package:flutter/material.dart';
import 'package:garagem_burger/models/usuario.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

  dynamic getUserCurrent() {
    if (usuario != null) {
      return usuario;
    }
    return null;
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
  login(String email, String senha, bool manterLogin) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      await _auth.currentUser!.getIdTokenResult(manterLogin);
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

  signInWithGoogle() async {
    final googleUser = GoogleSignIn();
    final GoogleSignInAccount? googleUserAccount = await googleUser.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUserAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    _auth.signInWithCredential(credential);
    _getUser();
  }

  signInWithFacebook() async {
    // TODO: Com erro (Colocar token no style.xml).
    print("Entrei no facebook");
    final LoginResult loginResult = await FacebookAuth.instance.login();

    print("Passo 1: no facebook");
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    print("Passo 2 no facebook");
    _auth.signInWithCredential(facebookAuthCredential);
    _getUser();
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
    await firestore.collection('usuarios').doc(user!.uid).delete();
    _getUser();
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
