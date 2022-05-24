import 'package:garagem_burger/models/produto.dart';

class Combo extends Produto {
  final List<Map<String, dynamic>> itens;

  Combo({
    required this.itens,
    required String id,
    required String nome,
    required double preco,
    required String urlImage,
  }) : super(
          id: id,
          nome: nome,
          preco: preco,
          tipo: Produto.combo,
          urlImage: urlImage,
        );
}
