// ignore_for_file: prefer_void_to_null, override_on_non_overriding_member

import 'package:garagem_burger/controllers/firebase.dart';
import 'package:garagem_burger/controllers/validacoes_usuario.dart';
import 'package:garagem_burger/models/usuario.dart';
import 'package:rxdart/rxdart.dart';

// ignore: constant_identifier_names
enum EstadoNovoUsuario { PARADO, CARREGANDO, SUCESSO, FALHA }

class NovoUsuario extends ValidacoesUsuario {
  late Usuario usuario;
  late Firebase firebase;
  late Map<String, dynamic> dadosUsuario;

  //Controllers
  final _nomeController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();
  final _confirmarSenhaController = BehaviorSubject<String>();
  final _telefoneController = BehaviorSubject<String>();
  final _estadoController = BehaviorSubject<EstadoNovoUsuario>();

  //Streams
  Stream<String> get outName => _nomeController.stream.transform(validacaoNome);
  Stream<String> get outPhone =>
      _telefoneController.stream.transform(validacaoTelefone);
  Stream<String> get outEmail =>
      _emailController.stream.transform(validacaoEmail);
  Stream<String> get outPassword =>
      _senhaController.stream.transform(validacaoSenha);
  Stream<String> get outConfirmPassword =>
      _senhaController.stream.transform(validacaoConfirmarSenha);
  Stream<EstadoNovoUsuario> get outState => _estadoController.stream;

  Function(String) get changeName => _nomeController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePhone => _telefoneController.sink.add;
  Function(String) get changePassword => _senhaController.sink.add;
  Function(String) get changeConfirmPassword =>
      _confirmarSenhaController.sink.add;

  NovoUsuario() {
    usuario = Usuario();
    firebase = Firebase();
    _estadoController.add(EstadoNovoUsuario.PARADO);
  }

  @override
  void dispose() {
    _nomeController.close();
    _emailController.close();
    _telefoneController.close();
    _senhaController.close();
    _confirmarSenhaController.close();
    _estadoController.close();
  }

  void cadastrarUsuario() async {
    if (!_emailController.hasValue ||
        !_senhaController.hasValue ||
        !_confirmarSenhaController.hasValue ||
        !_nomeController.hasValue ||
        !_telefoneController.hasValue) {
      _estadoController.add(EstadoNovoUsuario.FALHA);
    } else {
      usuario.nome = _nomeController.value;
      usuario.email = _emailController.value;
      usuario.telefone = _telefoneController.value;
      usuario.senha = _senhaController.value;

      dadosUsuario = usuario.usuario();

      _estadoController.add(EstadoNovoUsuario.CARREGANDO);

      firebase.firebaseAuth
          .createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha,
      )
          .then((usuarioAtual) async {
        //firebase.firebaseUser = usuarioAtual as User;
        firebase.firebaseUser = usuarioAtual.user!;
        await _salvarDados(dadosUsuario);
      }).catchError((erro) {
        _estadoController.add(EstadoNovoUsuario.FALHA);
      });
    }
  }

  Future<Null> _salvarDados(Map<String, dynamic> dadosUsuario) async {
    await firebase.firestore
        .collection("usuarios")
        .doc(firebase.firebaseUser.uid)
        .set(dadosUsuario);

    _estadoController.add(EstadoNovoUsuario.SUCESSO);
  }
}
