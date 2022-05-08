import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {
  static const bebida = 'Bebida';
  static const acompanhamento = 'Acompanhamento';
  static const sobremesa = 'Sobremesa';
  static const hamburguerCasa = 'Hambúrgueres da Casa';

  late String id;
  late String nome;
  late double preco;
  late String tipo;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.tipo,
  });

  Produto.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    nome = snapshot.get('nome');
    preco = snapshot.get('preco') + 0.0;
    tipo = snapshot.get('tipo');
    //descricao = snapshot.data["descricao"];
    //img = snapshot.data["img"];
  }
}