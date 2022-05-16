class Localizacao {
  String id;
  String cep;
  String rua;
  String numero;
  String bairro;
  String cidade;
  String estado;
  bool favorito;
  String? complemento;
  String? descricao;

  Localizacao({
    required this.id,
    required this.rua,
    required this.cep,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.favorito,
    this.descricao,
    this.complemento,
  });

  Map<String, dynamic> toMapWithoutId() {
    return {
      "cep": cep,
      "rua": rua,
      "bairro": bairro,
      "cidade": cidade,
      "estado": estado,
      "numero": numero,
      "descricao": descricao,
      "complemento": complemento ?? "",
      "favorito": favorito,
    };
  }

  // Localizacao.fromDocument(DocumentSnapshot snapshot) {
  //   id = snapshot.id;
  //   rua = snapshot.get('rua');
  //   cep = snapshot.get('cep');
  //   numero = snapshot.get('numero');
  //   cidade = snapshot.get('cidade');
  //   estado = snapshot.get('estado');
  //   descricao = snapshot.get('descricao');
  //   favorito = snapshot.get('favorito') as bool;
  // }
}
