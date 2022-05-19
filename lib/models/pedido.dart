import 'package:cloud_firestore/cloud_firestore.dart';

class Pedido {
  static const pendente = 'pendente';
  static const entregue = 'entregue';
  static const cancelado = 'cancelado';

  final String id;
  final DateTime data;
  String status;
  final List<Map<String, dynamic>> itens;
  final String enderecoEntrega;
  final String metodoPagamento;
  final double frete;
  final double total;
  final List<Map<String, dynamic>> etapas;

  Pedido({
    required this.id,
    required this.data,
    required this.status,
    required this.itens,
    required this.enderecoEntrega,
    required this.metodoPagamento,
    required this.frete,
    required this.total,
    required this.etapas,
  });

  factory Pedido.fromMap(String id, Map<String, dynamic> dados) {
    return Pedido(
      id: id,
      data: (dados['data'] as Timestamp).toDate(),
      status: dados['status'],
      itens: (dados['itens'] as List<dynamic>).map((item) {
        return {
          'id': (item['id'] as DocumentReference<Map<String, dynamic>>).id,
          'quantidade': item['quantidade'],
        };
      }).toList(),
      enderecoEntrega:
          (dados['enderecoEntrega'] as DocumentReference<Map<String, dynamic>>)
              .id,
      metodoPagamento: dados['metodoPagamento'],
      frete: dados['frete'] * 1.0,
      total: dados['total'] * 1.0,
      etapas: (dados['etapas'] as List<dynamic>).map((etapa) {
        return {
          'isComplete': (etapa as Map<String, dynamic>)['isComplete'] as bool,
          'date': (etapa['date'] as Timestamp).toDate(),
        };
      }).toList(),
    );
  }
}
