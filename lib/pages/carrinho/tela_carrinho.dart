import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/card_dismissible.dart';
import 'package:garagem_burger/components/popup_dialog.dart';
import 'package:garagem_burger/pages/localizacao/tela_adicionar_localizacao.dart';
import 'package:garagem_burger/pages/menu/tela_menu.dart';
import 'package:garagem_burger/pages/tela_vazia.dart';
import 'package:garagem_burger/providers/provider_carrinho.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TelaCarrinho extends StatelessWidget {
  const TelaCarrinho({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Carrinho';

  Future _limparCarrinho(context) {
    final provider = Provider.of<ProviderCarrinho>(
      context,
      listen: false,
    );
    return showDialog(
      context: context,
      builder: (context) {
        return PopupDialog(
          titulo: 'Limpar carrinho',
          descricao: 'Deseja excluir todos os iens do carrinho?',
          onPressedYesOption: () {
            Navigator.of(context).pop();
            provider.limparCarrinho();
          },
          onPressedNoOption: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Widget _buildTela(BuildContext context) {
    final provider = Provider.of<ProviderCarrinho>(
      context,
      listen: false,
    );

    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () {
                Future.delayed(
                  const Duration(seconds: 0),
                  () => _limparCarrinho(context),
                );
              },
              label: Text(
                'Limpar carrinho',
                style: GoogleFonts.oxygen(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.left,
              ),
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          ],
        ),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'R\$ ${provider.precoTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
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
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Botao(
                    labelText: 'Efetuar pedido',
                    onPressed: () {
                      Navigator.of(context).pushNamed(Rotas.main,
                          arguments: [2, const TelaAdicionarLocalizacao()]);
                    },
                  ),
                )
              ],
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
        arguments: [0, const TelaMenu()],
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
