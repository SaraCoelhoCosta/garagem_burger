import 'package:garagem_burger/models/produto.dart';

class Bebida extends Produto {
  
  
  
  Bebida({
    required String id,
    required String nome,
    required double preco,
    required String tipo,
  }) : super(id: id, nome: nome, preco: preco, tipo: tipo);
}
