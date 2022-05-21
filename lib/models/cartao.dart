class Cartao {
  final String id;
  late final String nomeTitular;
  late final String numeroCartao;
  late final String dataVencimento;
  late final String cvv;
  final String tipo;
  //final String bandeira;
  String descricao;
  bool favorito;

  Cartao({
    required this.id,
    required this.nomeTitular,
    required this.numeroCartao,
    required this.cvv,
    required this.dataVencimento,
    required this.tipo,
    required this.descricao,
    this.favorito = false,
  });

  factory Cartao.fromMap(String id, Map<String, dynamic> dados) {
    return Cartao(
      id: id,
      nomeTitular: dados['nomeTitular'],
      numeroCartao: dados['numeroCartao'],
      cvv: dados['cvv'],
      dataVencimento: dados['dataVencimento'],
      tipo: dados['tipo'],
      favorito: dados['favorito'],
      descricao: dados['descricao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nomeTitular': nomeTitular,
      'numeroCartao': numeroCartao,
      'cvv': cvv,
      'tipo': tipo,
      'dataVencimento': dataVencimento,
      'descricao': descricao,
      'favorito': favorito,
    };
  }
}
