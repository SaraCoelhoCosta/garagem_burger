class Pedido {
  static const pendente = 'pendente';
  static const entregue = 'entregue';
  static const cancelado = 'cancelado';

  final String id;
  final DateTime data;
  final String status;
  final List<Map<String, dynamic>> itens;
  final String enderecoEntrega;
  final String metodoPagamento;
  final double frete;
  final double total;

  Pedido({
    required this.id,
    required this.data,
    required this.status,
    required this.itens,
    required this.enderecoEntrega,
    required this.metodoPagamento,
    required this.frete,
    required this.total,
  });

  factory Pedido.fromMap(String id, Map<String, dynamic> dados) {
    return Pedido(
      id: id,
      data: DateTime.parse(dados['data']),
      status: dados['status'],
      itens: (dados['itens'] as List<dynamic>).map((item) {
        return {
          'id': item['id'],
          'quantidade': item['quantidade'],
        };
      }).toList(),
      enderecoEntrega: dados['enderecoEntrega'],
      metodoPagamento: dados['metodoPagamento'],
      frete: dados['frete'],
      total: dados['total'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.toIso8601String(),
      'status': status,
      'itens': itens,
      'enderecoEntrega': enderecoEntrega,
      'metodoPagamento': metodoPagamento,
      'frete': frete,
      'total': total,
    };
  }
}
