import 'package:cloud_firestore/cloud_firestore.dart';

class Localizacao {
  late String id;
  late String cep;
  late String rua;
  late String numero;
  late String bairro;
  late String cidade;
  late String estado;
  late bool favorito;
  late String? complemento;
  late String? descricao;

  Localizacao({
    required this.id,
    required this.rua,
    required this.cep,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.favorito,
    this.descricao,
    this.complemento,
  });

  Localizacao.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    id = snapshot.id;
    rua = snapshot.data()['rua'];
    cep = snapshot.data()['cep'];
    bairro = snapshot.data()['bairro'];
    numero = snapshot.data()['numero'];
    cidade = snapshot.data()['cidade'];
    estado = snapshot.data()['estado'];
    descricao = snapshot.data()['descricao'];
    favorito = snapshot.data()['favorito'];
  }

  Map<String, dynamic> toMapWithoutId() {
    return {
      "cep": cep,
      "rua": rua,
      "bairro": bairro,
      "cidade": cidade,
      "estado": estado,
      "numero": numero,
      "descricao": descricao,
      "complemento": complemento,
      "favorito": favorito,
    };
  }

  // Localizacao.fromDocument(DocumentSnapshot snapshot) {
  //   id = snapshot.id;
  //   rua = snapshot.get('rua');
  //   cep = snapshot.get('cep');
  //   numero = snapshot.get('numero');
  //   cidade = snapshot.get('cidade');
  //   estado = snapshot.get('estado');
  //   descricao = snapshot.get('descricao');
  //   favorito = snapshot.get('favorito') as bool;
  // }
}
