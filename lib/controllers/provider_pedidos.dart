import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garagem_burger/controllers/firebase.dart';
import 'package:garagem_burger/models/item_carrinho.dart';
import 'package:garagem_burger/models/pedido.dart';

class ProviderPedidos with ChangeNotifier {
  final Map<String, Pedido> _pedidos = {};
  late String _enderecoEntrega;
  late String _metodoPagamento;
  late double _frete;

  late FirebaseFirestore firestore;

  ProviderPedidos() {
    _startProvider();
  }

  _startProvider() async {
    await _startFirestore();
  }

  _startFirestore() {
    firestore = Firebase.getFirestore();
  }

  Map<String, Pedido> get pedidos => {..._pedidos};

  int get qntPedidos => _pedidos.length;

  bool get emptyList => _pedidos.isEmpty;

  void setEnderecoEntrega(String enderecoEntrega) {
    _enderecoEntrega = enderecoEntrega;
  }

  void setFrete(double frete) {
    _frete = frete;
  }

  void setMetodoPagamento(String metodoPagamento) {
    _metodoPagamento = metodoPagamento;
  }

  // Adiciona um novo pedido
  Future<void> addPedido(
      User? user, List<ItemCarrinho> itens, double total) async {
    final currentDate = DateTime.now();
    // Adiciona no bd
    final doc =
        await firestore.collection('usuarios/${user!.uid}/pedidos').add({
      'data': currentDate.toIso8601String(),
      'status': 'pendente',
      'itens': itens.map((item) {
        return {
          'id': item.produto.id,
          'quantidade': item.quantidade,
        };
      }).toList(),
      'enderecoEntrega': _enderecoEntrega,
      'metodoPagamento': _metodoPagamento,
      'frete': _frete,
      'total': total,
    });

    // Adiciona na lista
    _pedidos.putIfAbsent(
      doc.id,
      () => Pedido(
        id: doc.id,
        data: currentDate,
        status: 'pendente',
        itens: itens.map((item) {
          return {
            'id': item.produto.id,
            'quantidade': item.quantidade,
          };
        }).toList(),
        enderecoEntrega: _enderecoEntrega,
        metodoPagamento: _metodoPagamento,
        frete: _frete,
        total: total,
      ),
    );
    notifyListeners();
  }

  // Atualiza os dados do pedido no bd
  Future<void> updatePedido(User? user, Pedido pedido) async {
    await firestore
        .collection('usuarios/${user!.uid}/pedidos')
        .doc(pedido.id)
        .update(pedido.toMap());
    notifyListeners();
  }

  // Carrega os pedidos do usuário que estão no firebase
  Future<void> loadPedidos(User? user) async {
    if (user != null) {
      _pedidos.clear();
      final snapshot = await Firebase.getFirestore()
          .collection('usuarios/${user.uid}/pedidos')
          .get();
      snapshot.docs.asMap().forEach((_, doc) {
        _pedidos.putIfAbsent(
          doc.id,
          () => Pedido.fromMap(doc.id, doc.data()),
        );
      });
      notifyListeners();
    }
  }
}
