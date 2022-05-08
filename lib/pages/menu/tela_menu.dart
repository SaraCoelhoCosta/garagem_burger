import 'package:flutter/material.dart';
import 'package:garagem_burger/controllers/auth_service.dart';
import 'package:garagem_burger/controllers/provider_produtos.dart';
import 'package:garagem_burger/components/card_produto.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:garagem_burger/components/mini_card_produto.dart';
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
    final provider = Provider.of<ProviderProdutos>(context);
    final user = Provider.of<AuthService>(context).usuario;
    final userName = user?.email ?? 'Convidado';
    // Altura total da tela, subtraindo as alturas da appBar e bottomBar
    final availableHeight = MediaQuery.of(context).size.height -
        (Scaffold.of(context).appBarMaxHeight ?? 0) -
        kBottomNavigationBarHeight;

    return ListView(
      children: [
        /*
        * Opções da aba superior (Filtros e perfil de usuário)
        */
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
                    'Bem Vindo, $userName!',
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
        /*
        * Botão Monte seu Próprio Hamburguer
        */
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            Rotas.montarHamburguer,
          ),
          child: Container(
            height: availableHeight * 0.40,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/montar-hamburguer.jpeg'),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 25),
                Text(
                  'Monte seu\npróprio\nhambúrguer',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.keaniaOne(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        /*
        * Seção Ofertas Especiais
        */
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
        /* 
        * Lista de Ofertas Especiais
        */
        Container(
          width: double.infinity,
          height: 100,
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (ctx, _) => const MiniCardProduto(),
          ),
        ),
        /*
        * Seção Hamburgueres da Casa
        */
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
        /*
        * Lista de Hamburgueres da Casa
        */
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: provider.hamburgueres
              .map((produto) => CardProduto(
                    produto: produto,
                    onTap: () => Navigator.of(context).pushNamed(
                      Rotas.produto,
                      arguments: [false, produto],
                    ),
                  ))
              .toList(),
        ),
        /*
        * Seção de Acompanhamentos
        */
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 8.0,
          ),
          child: Text(
            'ACOMPANHAMENTOS',
            style: GoogleFonts.oxygen(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        /*
        * Lista de Acompanhamentos
        */
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: provider.acompanhamentos
              .map((produto) => CardProduto(
                    produto: produto,
                    onTap: () => Navigator.of(context).pushNamed(
                      Rotas.produto,
                      arguments: [false, produto],
                    ),
                  ))
              .toList(),
        ),
        /*
        * Seção de Sobremesas
        */
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 8.0,
          ),
          child: Text(
            'SOBREMESAS',
            style: GoogleFonts.oxygen(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        /*
        * Lista de Sobremesas
        */
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: provider.sobremesas
              .map((produto) => CardProduto(
                    produto: produto,
                    onTap: () => Navigator.of(context).pushNamed(
                      Rotas.produto,
                      arguments: [false, produto],
                    ),
                  ))
              .toList(),
        ),
        /*
        * Seção de Bebidas
        */
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 8.0,
          ),
          child: Text(
            'BEBIDAS',
            style: GoogleFonts.oxygen(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        /*
        * Lista de Bebidas
        */
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: provider.bebidas
              .map((produto) => CardProduto(
                    produto: produto,
                    onTap: () => Navigator.of(context).pushNamed(
                      Rotas.produto,
                      arguments: [false, produto],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
