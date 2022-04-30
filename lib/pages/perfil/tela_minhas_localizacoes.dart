import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaMinhasLocalizacoes extends StatelessWidget {
  const TelaMinhasLocalizacoes({ Key? key }) : super(key: key);

  @override
  String toStringShort() => 'Minhas Localizações';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Minhas Localizações',
        style: GoogleFonts.oxygen(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}