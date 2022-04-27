import 'package:flutter/material.dart';
import 'package:garagem_burger/data/rotas.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaVazia extends StatelessWidget {
  final String pageName;
  final IconData icon;
  final String rota;
  final String titulo;
  final String subtitulo;
  final String rodape;

  const TelaVazia({
    Key? key,
    required this.pageName,
    required this.icon,
    required this.rota,
    required this.titulo,
    required this.subtitulo,
    required this.rodape,
  }) : super(key: key);

  @override
  String toStringShort() => pageName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            Icon(icon, size: 100),
            const SizedBox(height: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 150,
                  width: 300,
                  child: TextButton(
                    onPressed: () => Rotas.nvgComRetorno(
                      context: context,
                      rota: rota,
                    ),
                    child: Text(
                      titulo,
                      style: GoogleFonts.oxygen(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 60, bottom: 60, left: 50, right: 50),
                  child: Text(
                    subtitulo,
                    style: GoogleFonts.oxygen(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
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
            const SizedBox(height: 20)
          ],
        ),
      ],
    );
  }
}
