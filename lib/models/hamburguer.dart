import 'package:garagem_burger/models/ingrediente.dart';
import 'package:garagem_burger/models/produto.dart';

class Hamburguer extends Produto {
  
  final List<Map<String, dynamic>> ingredientes;
  
  Hamburguer({
    required String id,
    required String nome,
    required double preco,
    String tipo = Produto.hamburguerCasa,
    required this.ingredientes,
  }) : super(id: id, nome: nome, preco: preco, tipo: tipo);



}
