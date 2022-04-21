class Usuario {
  late String nome;
  late String email;
  late String telefone;
  late String senha;
  String? confirmarSenha;

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'senha:': senha,
      'confirmarSenha:': confirmarSenha,
    };
  }
}
