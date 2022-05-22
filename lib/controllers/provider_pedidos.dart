// ignore_for_file: avoid_print

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

  Map<String, Pedido> get pedidos {
    Map<String, Pedido> temp = {};
    _pedidos.values.toList().reversed.toList().forEach((pedido) {
      temp.putIfAbsent(pedido.id, () => pedido);
    });
    return temp;
  }

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
    User? user,
    List<ItemCarrinho> itens,
    double total,
  ) async {
    final currentDate = DateTime.now();
    final refLocal = firestore
        .collection('usuarios/${user!.uid}/localizacoes')
        .doc(_enderecoEntrega);

    // Adiciona no bd
    final doc = await firestore.collection('usuarios/${user.uid}/pedidos').add({
      'data': Timestamp.fromDate(currentDate),
      'status': 'pendente',
      'itens': itens.map((item) {
        final refProduct =
            firestore.collection('produtos').doc(item.produto.id);
        return {
          'id': refProduct,
          'quantidade': item.quantidade,
        };
      }).toList(),
      'enderecoEntrega': refLocal,
      'metodoPagamento': _metodoPagamento,
      'frete': _frete,
      'total': total,
      'etapas': [
        {
          'date': Timestamp.fromDate(currentDate),
          'isComplete': false,
        }
      ],
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
        etapas: [
          {
            'date': currentDate,
            'isComplete': false,
          }
        ],
      ),
    );

    startOrder(user, _pedidos.values.last);

    notifyListeners();
  }

  // Inicia o processo de acompanhamento do pedido
  Future<void> startOrder(User? user, Pedido pedido) async {
    for (int i = 0; i < 4; i++) {
      // Aguarda um tempo para concluir uma etapa e iniciar uma nova
      await Future.delayed(const Duration(seconds: 5));

      // Verifica se o pedido foi cancelado, antes de continuar
      if (pedido.status == Pedido.cancelado) {
        notifyListeners();
        return;
      }

      pedido.etapas[i]['isComplete'] = true;
      if (i < 3) {
        pedido.etapas.add({
          'isComplete': false,
          'date': DateTime.now(),
        });
      }

      // Atualiza na lista
      _pedidos.update(pedido.id, (_) => pedido);
      notifyListeners();

      // Atualiza no bd
      await updatePedido(user, pedido);
    }

    // Atualiza na lista
    pedido.status = Pedido.entregue;
    _pedidos.update(pedido.id, (_) => pedido);
    notifyListeners();

    // Atualiza no bd
    await updatePedido(user, pedido);
  }

  // Atualiza os dados do pedido no bd
  Future<void> updatePedido(User? user, Pedido pedido) async {
    await firestore
        .collection('usuarios/${user!.uid}/pedidos')
        .doc(pedido.id)
        .update({
      'data': Timestamp.fromDate(pedido.data),
      'status': pedido.status,
      'itens': pedido.itens.map((item) {
        return {
          'id': firestore.collection('produtos').doc(item['id']),
          'quantidade': item['quantidade'],
        };
      }).toList(),
      'enderecoEntrega': firestore
          .collection('usuarios/${user.uid}/localizacoes')
          .doc(pedido.enderecoEntrega),
      'metodoPagamento': pedido.metodoPagamento,
      'frete': pedido.frete,
      'total': pedido.total,
      'etapas': pedido.etapas.map((etapa) {
        return {
          'date': Timestamp.fromDate(etapa['date'] as DateTime),
          'isComplete': etapa['isComplete'] as bool,
        };
      }).toList(),
    });
    notifyListeners();
  }

  Future<bool> cancelOrder(User? user, Pedido pedido) async {
    if (pedido.etapas.length <= 2 && !pedido.etapas[1]['isComplete']) {
      pedido.status = Pedido.cancelado;
      _pedidos.update(pedido.id, (_) => pedido);
      await updatePedido(user, pedido);
      return true;
    } else {
      return false;
    }
  }

  // Carrega os pedidos do usuário que estão no firebase
  Future<void> loadPedidos(User? user) async {
    if (user != null) {
      _pedidos.clear();
      final snapshot = await Firebase.getFirestore()
          .collection('usuarios/${user.uid}/pedidos')
          .orderBy('data')
          .get();
      snapshot.docs.asMap().forEach((_, doc) {
        _pedidos.putIfAbsent(
          doc.id,
          () => Pedido.fromMap(doc.id, doc.data()),
        );
      });
      print('$qntPedidos pedidos carregados.');
      notifyListeners();
    }
  }
}
