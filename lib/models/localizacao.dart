import 'package:cloud_firestore/cloud_firestore.dart';

class Localizacao {
  late String id;
  late String cep;
  late String rua;
  late int numero;
  late String bairro;
  late String cidade;
  late String estado;
  late bool favorito;
  late String? descricao;

  Localizacao({
    required this.id,
    required this.rua,
    required this.cep,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
    this.favorito = false,
    this.descricao, // TODO: coloca como obrigatório?
  });

  Localizacao.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    rua = snapshot.get('rua');
    cep = snapshot.get('cep');
    numero = snapshot.get('numero') + 0;
    cidade = snapshot.get('cidade');
    estado = snapshot.get('estado');
    descricao = snapshot.get('descricao');
    favorito = snapshot.get('favorito');
  }
}
