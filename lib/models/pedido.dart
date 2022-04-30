enum Status {
  pendente,
  entregue,
  cancelado,
}

class Pedido {
  final String id;
  final String data;
  final String hora;
  final Status status;

  Pedido({
    required this.id,
    required this.data,
    required this.hora,
    required this.status,
  });
}