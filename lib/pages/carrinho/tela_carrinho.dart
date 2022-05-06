import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/card_dismissible.dart';
import 'package:garagem_burger/components/row_price.dart';
import 'package:garagem_burger/pages/localizacao/tela_adicionar_localizacao.dart';
import 'package:garagem_burger/pages/menu/tela_menu.dart';
import 'package:garagem_burger/pages/tela_vazia.dart';
import 'package:garagem_burger/providers/provider_carrinho.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaCarrinho extends StatelessWidget {
  const TelaCarrinho({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Carrinho';

  Widget _buildTela(BuildContext context) {
    final provider = Provider.of<ProviderCarrinho>(
      context,
      listen: false,
    );

    return ListView(
      children: [
        /*
        * Itens do carrinho
        */
        Column(
          children: provider.itensCarrinho.values.map((itemCarrinho) {
            return CardDismissible(
              item: itemCarrinho,
              tipoCard: TipoCard.itemCarrinho,
              editar: () => Navigator.of(context).pushNamed(
                Rotas.produto,
                arguments: [true, itemCarrinho.produto],
              ),
              remover: (id) => provider.removeItemCarrinho(id),
            );
          }).toList(),
        ),
        /*
        * Total e botao de continuar
        */
        Padding(
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
                    value: provider.precoTotal,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dica: Clicando no ícone ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const Icon(Icons.create),
                      Text(
                        ' você pode editar a',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'quantidade ou configurar seu produto',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  Botao(
                    labelText: 'Efetuar pedido',
                    externalPadding: const EdgeInsets.only(top: 15),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        Rotas.main,
                        arguments: {
                          'index': 2,
                          'page': const TelaAdicionarLocalizacao(),
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
      ],
    );
  }

  Widget _buildTelaVazia(BuildContext context) {
    return TelaVazia(
      pageName: 'Meus Lanches',
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
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCarrinho>(context);
    return (provider.qntItens == 0)
        ? _buildTelaVazia(context)
        : _buildTela(context);
  }
}
