enum Tipo {
  bebida,
  hamburguer,
  sobremesa,
}

class Produto {
  final String id;
  final String nome;
  final double preco;
  final Tipo tipo;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.tipo,
  });
}
