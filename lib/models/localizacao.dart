class Localizacao {
  String id;
  String cep;
  String rua;
  String numero;
  String bairro;
  String cidade;
  String estado;
  bool favorito;
  String descricao;
  String? complemento;

  Localizacao({
    required this.id,
    required this.rua,
    required this.cep,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.favorito,
    required this.descricao,
    this.complemento,
  });

  factory Localizacao.fromMap(String id, Map<String, dynamic> dados) {
    return Localizacao(
      id: id,
      favorito: dados['favorito'],
      descricao: dados['descricao'],
      bairro: dados['bairro'],
      cep: dados['cep'],
      cidade: dados['cidade'],
      estado: dados['estado'],
      numero: dados['numero'],
      rua: dados['rua'],
      complemento: dados['complemento'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cep': cep,
      'rua': rua,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'numero': numero,
      'descricao': descricao,
      'complemento': complemento ?? '',
      'favorito': favorito,
    };
  }
}
