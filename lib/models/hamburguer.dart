import 'package:garagem_burger/models/ingrediente.dart';
import 'package:garagem_burger/models/produto.dart';

class Hamburguer extends Produto {
  final List<Map<String, dynamic>> ingredientes;

  Hamburguer({
    required this.ingredientes,
    required String id,
    required String nome,
    required double preco,
    required String urlImage,
    required int quantidade,
  }) : super(
          id: id,
          nome: nome,
          preco: preco,
          urlImage: urlImage,
          quantidade: quantidade,
          unidadeMedida: Ingrediente.g,
          tipo: Produto.hamburguerCasa,
        );

  int get totalIngredientes {
    return ingredientes.fold(0, (previousValue, ingrediente) {
      return ingrediente['quantidade'] + previousValue;
    });
  }
}
