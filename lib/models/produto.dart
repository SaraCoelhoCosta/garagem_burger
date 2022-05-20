class Produto {

  // Tipos
  static const bebida = 'Bebida';
  static const acompanhamento = 'Acompanhamento';
  static const sobremesa = 'Sobremesa';
  static const hamburguerCasa = 'Hambúrgueres da Casa';

  String id;
  String urlImage;
  String nome;
  double preco;
  String tipo;
  int quantidade;
  String unidadeMedida;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.tipo,
    required this.urlImage,
    required this.quantidade,
    required this.unidadeMedida,
  });
}