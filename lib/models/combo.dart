import 'package:garagem_burger/models/produto.dart';

class Combo extends Produto {
  final List<Map<String, dynamic>> item;

  Combo({
    required this.item,
    required String id,
    required String nome,
    required double preco,
    required String urlImage,
    required int quantidade,
  }) : super(
          id: id,
          nome: nome,
          preco: preco,
          tipo: Produto.combo,
          urlImage: urlImage,
          quantidade: quantidade,
          unidadeMedida: '',
        );

}
