import 'package:garagem_burger/models/produto.dart';

class Ingrediente extends Produto {
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
  static const ml = 'ml';
  static const l = 'L';
  static const fatia = 'fatia';

  Ingrediente({
    required String id,
    required String nome,
    required double preco,
    required String tipo,
    required String urlImage,
    required int quantidade,
    required String unidadeMedida,
  }) : super(
          id: id,
          nome: nome,
          preco: preco,
          tipo: tipo,
          urlImage: urlImage,
          quantidade: quantidade,
          unidadeMedida: unidadeMedida,
        );
}
