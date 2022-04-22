import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardProduto extends StatelessWidget {

  const CardProduto({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        top: 10.0,
      ),
      child: Card(
        elevation: 6.0,
        child: ListTile(
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            child: Image.asset('images/hamburguer.jpg'),
          ),
          title: Text(
            'Hambúrguer',
            style: GoogleFonts.oxygen(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'R\$ 20.00',
            style: GoogleFonts.oxygen(
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}