import 'package:flutter/material.dart';
import 'package:garagem_burger/screens/components/card_produto.dart';
import 'package:garagem_burger/screens/components/card_produto_simples.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaMenu extends StatelessWidget {
  const TelaMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Opcoes da aba superior (filtros e icone do usuario)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.filter_list,
                    size: 30,
                  ),
                  Text(
                    '  Filtros',
                    style: GoogleFonts.oxygen(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Bem Vindo, João!  ',
                    style: GoogleFonts.oxygen(
                      fontSize: 18,
                    ),
                  ),
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 30,
                  ),
                ],
              )
            ],
          ),
        ),

        // Ofertas Especiais
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 8.0,
          ),
          child: Text(
            'OFERTAS ESPECIAIS',
            style: GoogleFonts.oxygen(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Container(
          width: double.infinity,
          height: 100,
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              CardProdutoSimples(),
              CardProdutoSimples(),
              CardProdutoSimples(),
              CardProdutoSimples(),
              CardProdutoSimples(),
              CardProdutoSimples(),
            ],
          ),
        ),

        // Hamburgueres da casa
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 8.0,
          ),
          child: Text(
            'HAMBÚRGUERES DA CASA',
            style: GoogleFonts.oxygen(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const CardProduto(),
        const CardProduto(),
        const CardProduto(),
        const CardProduto(),
        const CardProduto(),
        const CardProduto(),
        const CardProduto(),
        const CardProduto(),
      ],
    );
  }
}
