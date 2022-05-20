class Ingrediente {
  
  // Tipos
  static const queijo = 'Queijo';
  static const legume = 'Legume';
  static const molho = 'Molho';
  static const cebola = 'Cebola';
  static const outros = 'Outros';
  static const pao = 'Pão';
  static const carne = 'Carne';

  // Unidades de medida
  static const mg = 'mg';
  static const g = 'g';
  static const un = 'un';
  static const mL = 'mL';
  static const fatia = 'fatia';

  final String id;
  final String nome;
  final double preco;
  final String tipo;
  final int quantidade;
  final String unidadeMedida;

  const Ingrediente({
    required this.id,
    required this.nome,
    required this.preco,
    required this.tipo,
    required this.quantidade,
    required this.unidadeMedida,
  });
}
