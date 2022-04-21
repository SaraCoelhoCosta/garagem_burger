import 'dart:async';

class ValidacoesUsuario {
  static late String _senha;

  final validacaoEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.length >= 6 && email.contains("@") && email.endsWith(".com")) {
      sink.add(email);
    } else {
      sink.addError("E-mail inválido");
    }
  });

  final validacaoNome =
      StreamTransformer<String, String>.fromHandlers(handleData: (nome, sink) {
    if (nome.trim().isNotEmpty) {
      sink.add(nome);
    } else {
      sink.addError('Nome inválido');
    }
  });

  final validacaoTelefone = StreamTransformer<String, String>.fromHandlers(
      handleData: (telefone, sink) {
    if (telefone.isNotEmpty) {
      sink.add(telefone);
    } else {
      sink.addError("Telefone inválido");
    }
  });

  final validacaoSenha =
      StreamTransformer<String, String>.fromHandlers(handleData: (senha, sink) {
    if (senha.length >= 6) {
      sink.add(senha);
      senha = _senha;
    } else {
      sink.addError("A senha deve conter 6 ou mais caracteres");
    }
  });

  final validacaoConfirmarSenha =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (confirmarSenha, sink) {
    if (confirmarSenha == _senha && _senha.isNotEmpty) {
      sink.add(confirmarSenha);
    } else {
      sink.addError("Senha diferente");
    }
  });
}
