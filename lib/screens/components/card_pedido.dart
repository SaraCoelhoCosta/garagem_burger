import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardPedido extends StatelessWidget {
  
  final String text;
  final IconData icon;
  final Color color;

  const CardPedido({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
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
            child: Image.asset('images/hamburguer.jpg'),
          ),
          title: Text(
            text,
            style: GoogleFonts.oxygen(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'às 21:00',
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
