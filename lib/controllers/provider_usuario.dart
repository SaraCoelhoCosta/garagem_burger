// ignore_for_file: prefer_final_fields, prefer_void_to_null, unused_element, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    await firestore.collection('usuarios').doc(usuario!.uid).set(dadosUsuario);
  }

  // Realiza login do usuário.
  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      // await _auth.currentUser!.getIdTokenResult(manterLogin);
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

  // Esqueceu senha.
  recuperarSenha(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      // Mensagem de erro.
      if (e.code == 'auth/user-not-found') {
        throw AuthException('E-mail não encontrado. Cadastre-se!');
      } else if (e.code == 'auth/invalid-email') {
        throw AuthException('E-mail inválido. Tente novamente!');
      }
    }
  }

  signInWithGoogle() async {
    // TODO: Cadastrar usuário e fazer logout.
    final googleUser = GoogleSignIn();
    final GoogleSignInAccount? googleUserAccount = await googleUser.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUserAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await _auth.signInWithCredential(credential);
    _getUser();
  }

  signInWithFacebook() async {
    // TODO: Com erro (Colocar token no style.xml), concluir login, cadastrar usuário e fazer logout.
    print('Entrei no facebook');
    final facebookUser = FacebookAuth.instance;

    print('Passo 1: no facebook');
    final LoginResult loginResult = await facebookUser.login();

    print('Passo 2: no facebook');
    final facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    print('Passo 3: no facebook');
    await _auth.signInWithCredential(facebookAuthCredential);

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

  // Alterar senha.
  redefinirSenha(String senhaAtual, String novaSenha) {
    if (usuario != null) {
      AuthCredential credential = EmailAuthProvider.credential(
          email: usuario!.email.toString(), password: senhaAtual);
      try {
        usuario!.reauthenticateWithCredential(credential).then((value) {
          //Conseguiu se reautenticar, então atualiza a senha
          usuario!.updatePassword(novaSenha).then((value) {});
        });
      } on FirebaseAuthException catch (e) {
        // Mensagem de erro.
        if (e.code == 'wrong-password') {
          throw AuthException('Senha inválida. Tente novamente!');
        }
      }
      _getUser();
    }
  }
}
