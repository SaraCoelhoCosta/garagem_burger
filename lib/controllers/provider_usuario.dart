// ignore_for_file: prefer_final_fields, prefer_void_to_null, unused_element, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:garagem_burger/controllers/firebase.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class ProviderUsuario extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = Firebase.getFirestore();
  FirebaseStorage storage = Firebase.getStorage();
  User? usuario;
  Map<String, dynamic>? userData;
  bool isLoading = true;
  bool primeiroAcesso = true;

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

  // Retorna os dados do usuario que estão salvos no firestore
  Future<void> loadUserData(User? user) async {
    final doc = await firestore.collection('usuarios').doc(usuario!.uid).get();
    userData = doc.data();
    if (userData != null) {
      print('Dados do usuário carregados com sucesso!');
    } else {
      print('Não há dados do usuário para serem carregados!');
    }
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

  Future<bool> verifyPassword(User? user, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: user!.email!,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return false;
      }
      return false;
    }
  }

  Future<bool> updatePassword(
    User? user,
    String password,
    String newPassword,
  ) async {
    // Verifica se a senha está correta
    if (await verifyPassword(user, password)) {
      // Tenta atualizar a senha
      try {
        await user!.updatePassword(newPassword);
        return true;
      } on FirebaseAuthException catch (_) {
        return false;
      }
    }

    return false;
  }

  // Realiza login do usuário.
  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);

      // await _auth.currentUser!.getIdTokenResult(manterLogin);
      _getUser();

      // Carrega os dados do usuário do firestore
      await loadUserData(_auth.currentUser);
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
    final googleUser = GoogleSignIn();
    final GoogleSignInAccount? googleUserAccount = await googleUser.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUserAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await _auth.signInWithCredential(credential).then((credencial) async {
      await firestore.collection("usuarios").get().then((value) async {
        value.docs.asMap().forEach((_,element) {
          if (element.get('email').toString() ==
              _auth.currentUser!.email.toString()) {
            primeiroAcesso = false;
          }
        });
      });
    });

    if (primeiroAcesso) {
      await firestore.collection('usuarios').doc(_auth.currentUser!.uid).set({
        'nome': _auth.currentUser!.displayName,
        'email': _auth.currentUser!.email,
        'telefone': '',
      });
    }
    _getUser();
  }

  signInWithFacebook() async {
    final fb = FacebookLogin();

    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
      FacebookPermission.userPhotos,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken accessToken = res.accessToken!;
        final profile = await fb.getUserProfile();
        final email = await fb.getUserEmail();

        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken.token);

        await _auth
            .signInWithCredential(facebookAuthCredential)
            .then((credencial) async {
          await firestore.collection("usuarios").get().then((value) async {
            value.docs.asMap().forEach((_,element) {
              if (element.get('email').toString() ==
                  _auth.currentUser!.email.toString()) {
                primeiroAcesso = false;
              }
            });
          });
        });

        if (primeiroAcesso) {
          await firestore
              .collection('usuarios')
              .doc(_auth.currentUser!.uid)
              .set({
            'nome': profile!.name,
            'email': email,
            'telefone': '',
          });
          //TODO: Foto do usuário (não está salvando).
          //final imageUrl = await fb.getProfileImageUrl(width: 100);
          //print('Your profile image: $imageUrl');
        }
        _getUser();

        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        throw AuthException(
            'Erro ao fazer login com Facebook. Tente novamente!');
    }
  }

  // Realiza o logout do usuário.
  logout() async {
    await _auth.signOut();
    _getUser();
  }

  // Atualiza os dados do usuário no BD
  Future<void> updateUsuario(
    User? user,
    Map<String, dynamic> dadosUsuario,
  ) async {
    userData = dadosUsuario;
    await firestore
        .collection('usuarios')
        .doc(usuario!.uid)
        .update(dadosUsuario);
    await _auth.currentUser!.updateDisplayName(dadosUsuario['nome'].toString());
    _getUser();
  }

  // Remove usuário
  Future<void> deleteUsuario(User? user) async {
    // TODO: Verificar se remove dados e usuário
    await firestore.collection('usuarios').doc(user!.uid).delete();
    await _auth.currentUser!.delete();
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
