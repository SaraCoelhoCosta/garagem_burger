import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/components/product_list.dart';
import 'package:garagem_burger/controllers/products.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Menu';

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool showFilters = false;
  int? currentFilter;
  List<String> filters = [
    'Montar Hambúrguer',
    'Hambúrgueres da Casa',
    'Combos',
    'Acompanhamentos',
    'Sobremesas',
    'Bebidas',
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Products>(context);
    String userName = 'Convidado';

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
              GestureDetector(
                onTap: () {
                  if (currentFilter == null) {
                    setState(() => showFilters = !showFilters);
                  }
                },
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
              ),
              /*
              * Perfil de usuário
              */
              Row(
                children: [
                  CustomText(
                    'Bem Vindo(a), $userName!',
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
        * Filtros
        */
        if (showFilters)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: 50,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return Offstage(
                  offstage:
                      (currentFilter == null) ? false : currentFilter != index,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: GestureDetector(
                      onTap: () {
                        if (currentFilter == index) {
                          setState(() => currentFilter = null);
                        } else {
                          setState(() => currentFilter = index);
                        }
                      },
                      child: Chip(
                        label: CustomText(filters[index]),
                        elevation: 2,
                        backgroundColor: (currentFilter == index)
                            ? Theme.of(context).backgroundColor
                            : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        /*
        * Botão Monte seu Próprio Hamburguer
        */
        if (currentFilter == null || currentFilter == 0)
          GestureDetector(
            onTap: () {},
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 200,
                maxHeight: 346,
              ),
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
        if (currentFilter == null || currentFilter == 1)
          ProductList(
            title: 'HAMBÚRGUERES DA CASA',
            produtos: provider.hamburgueres,
          ),
        if (currentFilter == null || currentFilter == 2)
          ProductList(
            title: 'COMBOS',
            produtos: provider.combos,
          ),
        if (currentFilter == null || currentFilter == 3)
          ProductList(
            title: 'ACOMPANHAMENTOS',
            produtos: provider.acompanhamentos,
          ),
        if (currentFilter == null || currentFilter == 4)
          ProductList(
            title: 'SOBREMESAS',
            produtos: provider.sobremesas,
          ),
        if (currentFilter == null || currentFilter == 5)
          ProductList(
            title: 'BEBIDAS',
            produtos: provider.bebidas,
          ),
      ],
    );
  }
}
