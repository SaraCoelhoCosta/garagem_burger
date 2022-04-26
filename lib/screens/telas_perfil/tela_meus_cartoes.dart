import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaMeusCartoes extends StatelessWidget {
  const TelaMeusCartoes({ Key? key }) : super(key: key);

  @override
  String toStringShort() => 'Meus Cartões';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffed80b),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Meus Cartões',
          style: GoogleFonts.keaniaOne(
            fontSize: 26.0,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Meus Cartões',
          style: GoogleFonts.oxygen(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}