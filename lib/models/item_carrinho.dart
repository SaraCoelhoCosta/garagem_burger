import 'package:garagem_burger/models/produto.dart';

class ItemCarrinho {
  final String id;
  final Produto produto;
  int quantidade;

  ItemCarrinho({
    required this.id,
    required this.produto,
    required this.quantidade,
  });
}