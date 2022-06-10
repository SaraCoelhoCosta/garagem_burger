import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_dismissible.dart';
import 'package:garagem_burger/controllers/pages.dart';
import 'package:garagem_burger/pages/empty_page.dart';
import 'package:garagem_burger/controllers/cart.dart';
import 'package:garagem_burger/utils/routes.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Carrinho';

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight! -
        kBottomNavigationBarHeight;

    final pvdCarrinho = Provider.of<Cart>(context);
    final pvdPages = Provider.of<Pages>(context);

    if ((pvdCarrinho.qntItens == 0)) {
      return EmptyPage(
        pageName: 'Carrinho',
        icon: Icons.shopping_cart_outlined,
        titulo: 'IR PARA O MENU',
        subtitulo: 'Carrinho vazio!\nFaça seu pedido.',
        rodape: 'Selecione o produto que deseja e adicione ao carrinho.',
        switchPage: () {
          pvdPages.setCurrentIndex(0);
        },
      );
    } else {
      return Column(
        children: [
          /*
          * Itens do carrinho
          */
          SizedBox(
            height: availableHeight * 0.60,
            child: ListView.builder(
              itemCount: pvdCarrinho.qntItens,
              itemBuilder: (ctx, index) {
                final items = pvdCarrinho.itensCarrinho.values.toList();
                return CardDismissible(
                  id: items[index].produto.id,
                  title: items[index].produto.nome,
                  image: 'images/hamburguer.jpg',
                  subtitle:
                      'R\$ ${items[index].produto.preco.toStringAsFixed(2)}',
                  itemCount: items[index].quantidade,
                  editar: () {
                    Navigator.of(context).pushNamed(
                      Routes.product,
                    );
                  },
                  remover: (id) => pvdCarrinho.removeItemCarrinho(id),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
