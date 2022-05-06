import 'package:flutter/material.dart';
import 'package:garagem_burger/data/dados.dart';
import 'package:garagem_burger/models/pedido.dart';

class ProviderPedidos with ChangeNotifier {

  final List<Pedido> _pedidos = pedidos;

  List<Pedido> get listaPedidos => [..._pedidos];

  int get qntPedidos => _pedidos.length;

  bool get emptyList => _pedidos.isEmpty;
}