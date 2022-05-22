import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:intl/intl.dart';

class OrderStatusRow extends StatelessWidget {
  final DateTime date;
  final int indexStatus; // Entre 0 e 4
  final bool isComplete;

  OrderStatusRow({
    Key? key,
    required this.date,
    required this.indexStatus,
    required this.isComplete,
  }) : super(key: key);

  final _textStatus = [
    {
      false: 'Confirmando pagamento...',
      true: 'Pagamento confirmado!',
    },
    {
      false: 'Seu pedido será preparado em breve...',
      true: 'Seu pedido entrou em preparo!',
    },
    {
      false: 'Aguardando preparação do pedido...',
      true: 'Seu pedido terminou de ser preparado!',
    },
    {
      false: 'Aguardando pedido sair para entrega...',
      true: 'Seu pedido saiu para entrega!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: (isComplete) ? Colors.green : Colors.grey,
            radius: 15,
          ),
          const SizedBox(width: 10),
          CustomText(
            '[' + DateFormat('hh:mm').format(date) + ']  ',
            fontSize: 20,
          ),
          Expanded(
            child: CustomText(
              _textStatus[indexStatus][isComplete] ?? '',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
