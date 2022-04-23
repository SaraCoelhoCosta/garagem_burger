class Usuario {
  late String nome;
  late String email;
  late String telefone;
  String senha = "";
  String confirmarSenha = "";

  Map<String, dynamic> usuario() {
    return {
      'nome': nome,
      'email': email,
      'telefone': telefone,
    };
  }
}
