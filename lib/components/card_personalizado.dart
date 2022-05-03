// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:garagem_burger/models/cartao.dart';
import 'package:garagem_burger/models/item_carrinho.dart';
import 'package:garagem_burger/models/localizacao.dart';
import 'package:garagem_burger/pages/cartoes/tela_alterar_cartao.dart';
import 'package:garagem_burger/pages/localizacao/tela_alterar_localizacao.dart';
import 'package:garagem_burger/providers/provider_carrinho.dart';
import 'package:garagem_burger/providers/provider_cartao.dart';
import 'package:garagem_burger/providers/provider_localizacoes.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

enum TipoCard {
  cartao,
  localizacao,
  itemCarrinho,
}

class CardPersonalizado extends StatelessWidget {
  final Object item;
  final TipoCard tipoCard;
  String id = '';
  String title = '';
  String subtitle = '';
  String? leadingImage;
  BoxFit? fit;
  bool? isFavorite;
  int? qntItens;
  double? width;

  CardPersonalizado({
    Key? key,
    required this.item,
    required this.tipoCard,
  }) : super(key: key);

  Future<bool?> _confirmRemove(context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Confirmar exclusão',
          style: TextStyle(color: Colors.red),
        ),
        content:
            const Text('Tem certeza que deseja excluir esse item da lista?'),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: const Text(
              'Não',
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          MaterialButton(
            elevation: 5.0,
            child: const Text(
              'Sim',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
  }

  void _removeFunction(BuildContext context) {
    switch (tipoCard) {
      case TipoCard.cartao:
        final tempItem = item as Cartao;
        Provider.of<ProviderCartao>(
          context,
          listen: false,
        ).removeCartao(tempItem);
        break;

      case TipoCard.localizacao:
        final tempItem = item as Localizacao;
        Provider.of<ProviderLocalizacoes>(
          context,
          listen: false,
        ).removeLocalizacao(tempItem);
        break;

      case TipoCard.itemCarrinho:
        final tempItem = item as ItemCarrinho;
        Provider.of<ProviderCarrinho>(
          context,
          listen: false,
        ).removeItemCarrinho(tempItem.produto.id);
        break;
    }
  }

  void _favoriteFunction(BuildContext context) {
    switch (tipoCard) {
      case TipoCard.cartao:
        final tempItem = item as Cartao;
        Provider.of<ProviderCartao>(
          context,
          listen: false,
        ).selectFavorite(tempItem);
        break;

      case TipoCard.localizacao:
        final tempItem = item as Localizacao;
        Provider.of<ProviderLocalizacoes>(
          context,
          listen: false,
        ).selectFavorite(tempItem);
        break;

      case TipoCard.itemCarrinho:
        // Nao tem
        break;
    }
  }

  void _selectTypeItem(BuildContext context) {
    switch (tipoCard) {
      case TipoCard.cartao:
        final tempItem = item as Cartao;
        id = tempItem.id;
        title = tempItem.description;
        subtitle = tempItem.cardNumber + '\nVencimento: ' + tempItem.dueDate;
        leadingImage = 'images/cartao1.jpg';
        fit = BoxFit.contain;
        isFavorite = tempItem.favorite;
        break;

      case TipoCard.localizacao:
        final tempItem = item as Localizacao;
        id = tempItem.id;
        title = '${tempItem.rua}, ${tempItem.numero.toString()} - ${tempItem.bairro}'
                '\n${tempItem.cidade}, ${tempItem.estado}';
        subtitle = tempItem.descricao!;
        leadingImage = null;
        isFavorite = tempItem.favorite;
        width = MediaQuery.of(context).size.width * 0.75;
        break;

      case TipoCard.itemCarrinho:
        final tempItem = item as ItemCarrinho;
        id = tempItem.id;
        title = tempItem.produto.nome;
        subtitle = 'R\$ ${tempItem.produto.preco.toStringAsFixed(2)}';
        leadingImage = 'images/hamburguer.jpg';
        fit = BoxFit.cover;
        qntItens = tempItem.quantidade;
        width = MediaQuery.of(context).size.width * 0.50;
        break;
    }
  }

  void _editFunction(BuildContext context) {
    switch (tipoCard) {
      case TipoCard.cartao:
        Navigator.of(context).pushNamed(
          Rotas.main,
          arguments: [3, const TelaAlterarCartao()],
        );
        break;

      case TipoCard.localizacao:
        Navigator.of(context).pushNamed(
          Rotas.main,
          arguments: [3, const TelaAlterarLocalizacao()],
        );
        break;

      case TipoCard.itemCarrinho:
        Navigator.of(context).pushNamed(
          Rotas.produto,
          arguments: [true, (item as ItemCarrinho).produto],
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _selectTypeItem(context);

    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10),
      ),
      onDismissed: (_) => _removeFunction(context),
      confirmDismiss: (_) => _confirmRemove(context),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 10.0,
        ),
        child: GestureDetector(
          onTap: () => _editFunction(context),
          child: Card(
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Leading (Image)
                  if (leadingImage != null)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        image: DecorationImage(
                          image: AssetImage(leadingImage!),
                          fit: fit,
                        ),
                      ),
                      width: MediaQuery.of(context).size.height * 0.15,
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),

                  // Title e subtitle
                  Container(
                    padding: const EdgeInsets.all(12),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Title
                        Text(
                          title, // max: 27 caracteres
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Subtitle
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Trailing (Marcar preferencial)
                  if(isFavorite != null)
                  IconButton(
                    onPressed: () => _favoriteFunction(context),
                    icon: (isFavorite!)
                        ? const Icon(
                            Icons.star,
                            color: Colors.amber,
                          )
                        : const Icon(Icons.star_border_outlined),
                  ),

                  // Trailing (quantidade de itens do carrinho)
                  if(qntItens != null)
                   // Quantidade de produtos
                    Container(
                      margin: const EdgeInsets.only(top: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).backgroundColor,
                      ),
                      constraints: const BoxConstraints(
                        minHeight: 25,
                        minWidth: 25,
                      ),
                      child: Center(
                        child: Text(
                          '${qntItens}x',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.oxygen(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
