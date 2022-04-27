import 'package:flutter/material.dart';
import 'package:garagem_burger/rotas.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaVazia extends StatelessWidget {
  const TelaVazia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final propriedades = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffed80b),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          propriedades['page'].toString(),
          style: GoogleFonts.keaniaOne(
            fontSize: 26.0,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Icon(propriedades['icon'] as IconData, size: 100),
              const SizedBox(height: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 150,
                    width: 300,
                    child: TextButton(
                      onPressed: () => Rotas.nvgSemRetorno(
                        context: context,
                        rota: propriedades['rota'].toString(),
                      ),
                      child: Text(
                        propriedades['titulo'].toString(),
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
                      propriedades['subtitulo'].toString(),
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
                propriedades['rodape'].toString(),
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
      ),
    );
  }
}
