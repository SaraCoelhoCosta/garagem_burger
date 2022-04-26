import 'package:flutter/material.dart';
import 'package:garagem_burger/models/produto.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaProduto extends StatelessWidget {

  const TelaProduto({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Produto';

  @override
  Widget build(BuildContext context) {

    Produto produto = ModalRoute.of(context)?.settings.arguments as Produto;

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

            // Nome do produto e preco
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  produto.nome,
                  style: GoogleFonts.oxygen(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'R\$ ${produto.preco}',
                  style: GoogleFonts.oxygen(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
