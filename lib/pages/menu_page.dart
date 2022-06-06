import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/components/product_list.dart';
import 'package:garagem_burger/controllers/products.dart';
import 'package:provider/provider.dart';

enum Filter {
  all,
  montarHamburguer,
  ofertas,
  hamburgueres,
  sobremesas,
  acompanhamentos,
  bebidas,
  combos,
}

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Menu';

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Filter filter = Filter.all;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Products>(context);
    const userName = 'Convidado';

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
              /*
              * Botão de filtrar
              */
              PopupMenuButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.filter_list,
                      size: 30,
                    ),
                    CustomText(
                      '  Filtros',
                      fontWeight: FontWeight.bold,
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
                    child: CustomText('Tudo'),
                  ),
                  const PopupMenuItem(
                    value: Filter.montarHamburguer,
                    child: CustomText('Montar Hambúrguer'),
                  ),
                  const PopupMenuItem(
                    value: Filter.hamburgueres,
                    child: CustomText('Hambúrgueres da Casa'),
                  ),
                  const PopupMenuItem(
                    value: Filter.acompanhamentos,
                    child: CustomText('Acompanhamentos'),
                  ),
                  const PopupMenuItem(
                    value: Filter.sobremesas,
                    child: CustomText('Sobremesas'),
                  ),
                  const PopupMenuItem(
                    value: Filter.bebidas,
                    child: CustomText('Bebidas'),
                  ),
                  const PopupMenuItem(
                    value: Filter.combos,
                    child: CustomText('Combos'),
                  ),
                ],
              ),
              /*
              * Perfil de usuário
              */
              Row(
                children: const [
                  CustomText(
                    'Bem Vindo, $userName!',
                  ),
                  Icon(
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
            onTap: () {},
            child: Container(
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
                children: const [
                  SizedBox(width: 25),
                  CustomText(
                    'Monte seu\npróprio\nhambúrguer',
                    textAlign: TextAlign.center,
                    fontSize: 30.0,
                    color: Colors.white,
                    fontType: FontType.title,
                  ),
                ],
              ),
            ),
          ),
        /*
        * Listas de produtos
        */
        if (filter == Filter.all || filter == Filter.hamburgueres)
          ProductList(
            title: 'HAMBÚRGUERES DA CASA',
            produtos: provider.hamburgueres,
          ),
        if (filter == Filter.all || filter == Filter.combos)
          ProductList(
            title: 'COMBOS',
            produtos: provider.combos,
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
    );
  }
}
