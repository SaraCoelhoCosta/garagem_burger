class Produto {

  // Tipos
  static const bebida = 'Bebida';
  static const acompanhamento = 'Acompanhamento';
  static const sobremesa = 'Sobremesa';
  static const hamburguerCasa = 'Hambúrgueres da Casa';
  static const combo = 'Combo';

  // Recipiente/Conjunto
  static const porcao = 'Porção';
  static const lata = 'Lata';
  static const garrafa = 'Garrafa';
  static const copo = 'Copo';

  String id;
  String urlImage;
  String nome;
  double preco;
  String tipo;
  int quantidade;
  String unidadeMedida;
  String? recipiente;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.tipo,
    required this.urlImage,
    required this.quantidade,
    required this.unidadeMedida,
    this.recipiente,
  });
}