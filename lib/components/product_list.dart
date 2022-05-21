import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_produto.dart';
import 'package:garagem_burger/components/card_ofertas.dart';
import 'package:garagem_burger/models/produto.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductList extends StatelessWidget {
  final String title;
  final List<Produto>? produtos;
  final bool isOfertasEspeciais;

  const ProductList({
    Key? key,
    required this.title,
    this.produtos,
    this.isOfertasEspeciais = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*
        * Titulo da Seção
        */
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 8.0,
          ),
          child: Text(
            title,
            style: GoogleFonts.oxygen(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        /*
        * Lista de Produtos
        */
        if (!isOfertasEspeciais && produtos != null)
          Column(
            children: produtos!.map(
              (produto) {
                return CardProduto(
                  produto: produto,
                  onTap: () => Navigator.of(context).pushNamed(
                    Rotas.produto,
                    arguments: [false, produto],
                  ),
                );
              },
            ).toList(),
          ),
        /*
        * Lista de Produtos com scroll horizontal
        */
        if (isOfertasEspeciais)
          Container(
            width: double.infinity,
            height: 100,
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (ctx, _) => const CardOfertas(),
            ),
          ),
      ],
    );
  }
}
