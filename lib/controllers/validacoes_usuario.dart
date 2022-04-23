// ignore_for_file: prefer_final_fields

import 'dart:async';

class ValidacoesUsuario {
  static String _senha = "";

  final validacaoEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.length >= 6 && email.contains("@") && email.endsWith(".com")) {
      sink.add(email);
    } else if (email.isEmpty) {
      sink.addError("E-mail obrigatório");
    } else {
      sink.addError("E-mail inválido");
    }
  });

  final validacaoNome =
      StreamTransformer<String, String>.fromHandlers(handleData: (nome, sink) {
    if (nome.contains(RegExp(r'[0-9]'))) {
      sink.addError('Nome inválido');
    }
    if (nome.trim().isEmpty) {
      sink.addError('Nome obrigatório');
    } else {
      sink.add(nome);
    }
  });

  final validacaoTelefone = StreamTransformer<String, String>.fromHandlers(
      handleData: (telefone, sink) {
    if (telefone.isEmpty) {
      sink.addError("Telefone obrigatório");
    } else {
      sink.add(telefone);
    }
  });

  final validacaoSenha =
      StreamTransformer<String, String>.fromHandlers(handleData: (senha, sink) {
    if (senha.length >= 6) {
      sink.add(senha);
      _senha = senha;
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
