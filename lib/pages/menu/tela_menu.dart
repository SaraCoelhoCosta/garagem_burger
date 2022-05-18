import 'package:flutter/material.dart';
import 'package:garagem_burger/components/product_list.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/controllers/provider_produtos.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

enum Filter {
  all,
  montarHamburguer,
  ofertas,
  hamburgueres,
  sobremesas,
  acompanhamentos,
  bebidas,
}

class TelaMenu extends StatefulWidget {
  const TelaMenu({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Menu';

  @override
  State<TelaMenu> createState() => _TelaMenuState();
}

class _TelaMenuState extends State<TelaMenu> {
  Filter filter = Filter.all;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderProdutos>(context);
    final user = Provider.of<ProviderUsuario>(context).usuario;
    final userName = user?.email ?? 'Convidado';
    // Altura total da tela, subtraindo as alturas da appBar e bottomBar
    final availableHeight = MediaQuery.of(context).size.height -
        (Scaffold.of(context).appBarMaxHeight ?? 0) -
        kBottomNavigationBarHeight;

    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(milliseconds: 100)).then((_) {
          setState(() => filter = Filter.all);
        });
      },
      child: ListView(
        children: [
          /*
          * Opções da aba superior (Filtros e perfil de usuário)
          */
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*
                * Botão de filtrar
                */
                PopupMenuButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
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
                  initialValue: filter,
                  onSelected: (selectedFilter) {
                    setState(() => filter = selectedFilter as Filter);
                  },
                  itemBuilder: (ctx) => [
                    const PopupMenuItem(
                      value: Filter.all,
                      child: Text('Tudo'),
                    ),
                    const PopupMenuItem(
                      value: Filter.montarHamburguer,
                      child: Text('Montar Hambúrguer'),
                    ),
                    const PopupMenuItem(
                      value: Filter.ofertas,
                      child: Text('Ofertas Especiais'),
                    ),
                    const PopupMenuItem(
                      value: Filter.hamburgueres,
                      child: Text('Hambúrgueres da Casa'),
                    ),
                    const PopupMenuItem(
                      value: Filter.acompanhamentos,
                      child: Text('Acompanhamentos'),
                    ),
                    const PopupMenuItem(
                      value: Filter.sobremesas,
                      child: Text('Sobremesas'),
                    ),
                    const PopupMenuItem(
                      value: Filter.bebidas,
                      child: Text('Bebidas'),
                    ),
                  ],
                ),
                /*
                * Perfil de usuário
                */
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
          if (filter == Filter.all || filter == Filter.montarHamburguer)
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                Rotas.montarHamburguer,
              ),
              child: Container(
                // height: availableHeight * 0.40,
                // Define a altura máxima de acordo com a altura da imagem,
                // para que ela não fique esticada demais
                constraints: const BoxConstraints(
                  minHeight: 200,
                  maxHeight: 346,
                ),
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
          * Listas de produtos
          */
          if (filter == Filter.all || filter == Filter.ofertas)
            const ProductList(
              title: 'OFERTAS ESPECIAIS',
              isOfertasEspeciais: true,
            ),
          if (filter == Filter.all || filter == Filter.hamburgueres)
            ProductList(
              title: 'HAMBÚRGUERES DA CASA',
              produtos: provider.hamburgueres,
            ),
          if (filter == Filter.all || filter == Filter.acompanhamentos)
            ProductList(
              title: 'ACOMPANHAMENTOS',
              produtos: provider.acompanhamentos,
            ),
          if (filter == Filter.all || filter == Filter.sobremesas)
            ProductList(
              title: 'SOBREMESAS',
              produtos: provider.sobremesas,
            ),
          if (filter == Filter.all || filter == Filter.bebidas)
            ProductList(
              title: 'BEBIDAS',
              produtos: provider.bebidas,
            ),
        ],
      ),
    );
  }
}
