class Produto {
  // Tipos
  static const bebida = 'Bebida';
  static const acompanhamento = 'Acompanhamento';
  static const sobremesa = 'Sobremesa';
  static const hamburguerCasa = 'Hambúrgueres da Casa';
  static const combo = 'Combo';
  static const meuHamburguer = 'Meu Hambúrguer';

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

  // Peso / Volume
  String? recipiente;
  int? quantidade;
  String? unidadeMedida;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.tipo,
    required this.urlImage,
    this.quantidade,
    this.unidadeMedida,
    this.recipiente,
  });

  bool get isEditable {
    return tipo == hamburguerCasa || tipo == meuHamburguer; // || tipo == combo;
  }
}
