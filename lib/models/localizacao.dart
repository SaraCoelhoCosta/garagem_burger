class Localizacao {
  final String id;
  final String rua;
  final int numero;
  final String bairro;
  final String cidade;
  final String estado;
  String? descricao;

  Localizacao({
    required this.id,
    required this.rua,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
    this.descricao,
  });
}
