// ignore_for_file: override_on_non_overriding_member

import 'dart:async';

import 'package:garagem_burger/controllers/firebase.dart';
import 'package:garagem_burger/controllers/validacoes_usuario.dart';
import 'package:garagem_burger/models/usuario.dart';
import 'package:rxdart/rxdart.dart';

// ignore: constant_identifier_names
enum EstadoLogin { PARADO, CARREGANDO, SUCESSO, FALHA }

class LoginUsuario extends ValidacoesUsuario {
  late Firebase firebase;
  late Usuario usuario;

  //Controllers
  final _emailController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();
  final _estadoController = BehaviorSubject<EstadoLogin>();

  //Streams
  late StreamSubscription _streamSubscription;
  Stream<String> get outEmail =>
      _emailController.stream.transform(validacaoEmail);
  Stream<String> get outPassword =>
      _senhaController.stream.transform(validacaoSenha);
  Stream<EstadoLogin> get outState => _estadoController.stream;

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _senhaController.sink.add;

  LoginUsuario() {
    usuario = Usuario();
    firebase = Firebase();

    // Logout (?)
    _streamSubscription =
        firebase.firebaseAuth.authStateChanges().listen((autenticacaoUsuario) {
      if (autenticacaoUsuario != null) {
        firebase.firebaseAuth
            .signOut(); //alterar essa linha quando logout for implementado

        _estadoController.add(EstadoLogin.SUCESSO);
      } else {
        _estadoController.add(EstadoLogin.PARADO);
      }
    });
  }

  @override
  void dispose() {
    _emailController.close();
    _senhaController.close();
    _estadoController.close();
    _streamSubscription.cancel();
  }

  void logarUsuario() {
    if (!_emailController.hasValue || !_senhaController.hasValue) {
      _estadoController.add(EstadoLogin.FALHA);
    } else {
      usuario.email = _emailController.value;
      usuario.senha = _senhaController.value;

      _estadoController.add(EstadoLogin.CARREGANDO);

      firebase.firebaseAuth
          .signInWithEmailAndPassword(
              email: usuario.email, password: usuario.senha)
          .catchError((erro) {
        _estadoController.add(EstadoLogin.FALHA);
      });
    }
  }
}
