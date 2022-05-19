class Usuario {
  late String id;
  late String nome;
  late String email;
  late String telefone;
  String senha = "";
  String confirmarSenha = "";

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'telefone': telefone,
    };
  }
}
