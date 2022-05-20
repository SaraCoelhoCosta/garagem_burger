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
    String unidadeMedida = Ingrediente.g,
    String tipo = Produto.hamburguerCasa,
  }) : super(
          id: id,
          nome: nome,
          preco: preco,
          tipo: tipo,
          urlImage: urlImage,
          unidadeMedida: unidadeMedida,
          quantidade: quantidade,
        );

  int get totalIngredientes {
    return ingredientes.fold(0, (previousValue, ingrediente) {
      return ingrediente['quantidade'] + previousValue;
    });
  }
}
