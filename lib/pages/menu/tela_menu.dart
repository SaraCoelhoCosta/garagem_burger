import 'package:flutter/material.dart';
import 'package:garagem_burger/providers/provider_produtos.dart';
import 'package:garagem_burger/components/card_produto.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:garagem_burger/components/card_produto_simples.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TelaMenu extends StatefulWidget {

  const TelaMenu({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Menu';

  @override
  State<TelaMenu> createState() => _TelaMenuState();
}

class _TelaMenuState extends State<TelaMenu> {
  @override
  Widget build(BuildContext context) {
    final produtos = Provider.of<ProviderProdutos>(context).listaProdutos;
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

        // Botao Monte seu proprio hamburguer
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            Rotas.montarHamburguer,
          ),
          child: Stack(
            children: [
              const Center(
                child:
                    Image(image: AssetImage('images/montar-hamburguer.jpeg')),
              ),
              // Container(
              //   height: 200,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15.0),
              //     image: const DecorationImage(
              //       image: AssetImage('images/montar-hamburguer.jpeg'),
              //     ),
              //   ),
              // ),
              Positioned(
                right: 170,
                top: 60,
                child: Text('Monte seu\npróprio\nhambúrguer',
                    style: GoogleFonts.keaniaOne(
                        fontSize: 26.0, color: Colors.white)),
              )
            ],
          )

          /*
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: const DecorationImage(
                image: AssetImage('images/montar-hamburguer.jpeg'),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 150),
              child: Text(
                'Monte seu\npróprio\nhambúrguer',
                textAlign: TextAlign.center,
                style: GoogleFonts.keaniaOne(
                  fontSize: 26.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          */

        ),

        // Titulo Ofertas Especiais
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

        // Ofertas especiais
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

        // Titulo Hamburgueres da casa
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

        // Hamburgueres da casa
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: produtos
              .map((produto) => CardProduto(
                    produto: produto,
                    onTap: () => Navigator.of(context).pushNamed(
                      Rotas.produto,
                      arguments: produto,
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
