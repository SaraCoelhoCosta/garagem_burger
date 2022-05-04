import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaVazia extends StatelessWidget {
  final String pageName;
  final IconData icon;
  final String titulo;
  final String subtitulo;
  final String rodape;
  final Function() navigator;

  const TelaVazia({
    Key? key,
    required this.pageName,
    required this.icon,
    required this.titulo,
    required this.subtitulo,
    required this.rodape,
    required this.navigator,
  }) : super(key: key);

  @override
  String toStringShort() => pageName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.15,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 120),
          TextButton(
            onPressed: navigator,
            child: Text(
              titulo,
              style: GoogleFonts.oxygen(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            subtitulo,
            style: GoogleFonts.oxygen(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            rodape,
            style: GoogleFonts.oxygen(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
