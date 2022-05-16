class Cartao {
  final String id;
  final String nomeTitular;
  final String numeroCartao;
  final String dataVencimento;
  final String cvv;
  final String tipo;
  //final String bandeira;
  String? descricao;
  bool favorito;

  Cartao({
    required this.id,
    required this.nomeTitular,
    required this.numeroCartao,
    required this.cvv,
    required this.dataVencimento,
    required this.tipo,
    this.descricao,
    this.favorito = false,
  });

  Map<String, dynamic> toMapWithoutId() {
    return {
      "nomeTitular": nomeTitular,
      "numeroCartao": numeroCartao,
      "cvv": cvv,
      "tipo": tipo,
      "dataVencimento": dataVencimento,
      "descricao": descricao,
      "favorito": favorito,
    };
  }
}
