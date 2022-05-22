import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/card_dismissible.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/components/row_price.dart';
import 'package:garagem_burger/pages/carrinho/tela_endereco_entrega.dart';
import 'package:garagem_burger/pages/menu/tela_menu.dart';
import 'package:garagem_burger/pages/tela_vazia.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaCarrinho extends StatelessWidget {
  const TelaCarrinho({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Carrinho';

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight! -
        kBottomNavigationBarHeight;

    final pvdCarrinho = Provider.of<ProviderCarrinho>(context);

    if ((pvdCarrinho.qntItens == 0)) {
      return TelaVazia(
        pageName: 'Carrinho',
        icon: Icons.shopping_cart_outlined,
        titulo: 'IR PARA O MENU',
        subtitulo: 'Carrinho vazio!\nFaça seu pedido.',
        rodape: 'Selecione o produto que deseja e adicione ao carrinho.',
        navigator: () => Navigator.of(context).pushReplacementNamed(
          Rotas.main,
          arguments: {
            'index': 0,
            'page': const TelaMenu(),
            'button': null,
          },
        ),
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
                  item: items[index],
                  tipoCard: TipoCard.itemCarrinho,
                  editar: () => Navigator.of(context).pushNamed(
                    Rotas.produto,
                    arguments: [true, items[index].produto],
                  ),
                  remover: (id) => pvdCarrinho.removeItemCarrinho(id),
                );
              },
            ),
          ),
          /*
          * Total e botao de continuar
          */
          SizedBox(
            height: availableHeight * 0.40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RowPrice(
                        text: 'Total',
                        value: pvdCarrinho.precoTotal,
                      ),
                      /*
                      * Dica
                      */
                      const CustomText(
                        'Dica: Clicando sobre o produto você pode editá-lo.\n'
                        'Caso queira excluí-lo, basta arrastar para a esquerda.',
                        color: Colors.grey,
                        fontSize: 18,
                        textAlign: TextAlign.center,
                      ),
                      /*
                      * Botão de continuar
                      */
                      Botao(
                        labelText: 'Efetuar pedido',
                        externalPadding: const EdgeInsets.only(top: 15),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            Rotas.main,
                            arguments: {
                              'index': 2,
                              'page': const TelaEnderecoEntrega(),
                              'button': null,
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }
  }
}
