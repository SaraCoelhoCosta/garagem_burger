import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaMontarHamburguer extends StatelessWidget {
  const TelaMontarHamburguer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('images/fundo-hamburguer.jpeg'),
          ),
        ),
        child: Column(
          children: [
            
            const SizedBox(height: 30),

            // Botao voltar
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Titulo
            Text(
              'Inicie uma\ncriativa jornada\npara matar a\nfome do\nseu jeito',
              textAlign: TextAlign.center,
              style: GoogleFonts.keaniaOne(
                color: Colors.white,
                fontSize: 45.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}