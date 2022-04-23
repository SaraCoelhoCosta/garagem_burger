import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaMeusLanches extends StatelessWidget {
  const TelaMeusLanches({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Meus Lanches',
        style: GoogleFonts.oxygen(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}