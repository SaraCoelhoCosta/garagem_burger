import 'package:flutter/material.dart';
import 'package:garagem_burger/models/pedido.dart';
import 'package:google_fonts/google_fonts.dart';

class CardPedido extends StatelessWidget {
  final Pedido pedido;

  const CardPedido(
    this.pedido, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    switch (pedido.status) {
      case Status.entregue:
        color = Colors.green;
        icon = Icons.check_circle_outline;
        break;
      case Status.pendente:
        color = const Color(0xfffed80b);
        icon = Icons.error_outline;
        break;
      case Status.cancelado:
        color = Colors.red;
        icon = Icons.cancel_outlined;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            width: 2.0,
            color: color,
          ),
        ),
        elevation: 6.0,
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset('images/pedido.jpg'),
          ),
          title: Text(
            'Pedido ${pedido.status.name} em ${pedido.data}',
            style: GoogleFonts.oxygen(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'às ${pedido.hora}',
            style: GoogleFonts.oxygen(
              fontSize: 16.0,
            ),
          ),
          contentPadding: const EdgeInsets.only(
            bottom: 6,
            left: 15,
            right: 6,
            top: 6,
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(top: 37, right: 5),
            child: Icon(
              icon,
              color: Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}
