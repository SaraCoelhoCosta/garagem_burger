import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaMeusPedidos extends StatelessWidget {
  const TelaMeusPedidos({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffed80b),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Meus Pedidos',
          style: GoogleFonts.keaniaOne(
            fontSize: 26.0,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Meus Pedidos',
          style: GoogleFonts.oxygen(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}