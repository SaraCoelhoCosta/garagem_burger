enum Tipo {
  bebida,
  hamburguer,
  sobremesa,
  acompanhamento,
}

class Produto {
  late String id;
  late String nome;
  late double preco;
  late Tipo tipo;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.tipo,
  });

}
