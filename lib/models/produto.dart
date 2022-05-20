class Produto {

  // Tipos
  // static const refrigerante = 'Refrigerante';
  // static const suco = 'Suco';
  static const bebida = 'Bebida';
  static const acompanhamento = 'Acompanhamento';
  static const sobremesa = 'Sobremesa';
  static const hamburguerCasa = 'Hambúrgueres da Casa';

  String id;
  String nome;
  double preco;
  String tipo;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.tipo,
  });
}