// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:garagem_burger/components/popup_dialog.dart';
import 'package:garagem_burger/models/cartao.dart';
import 'package:garagem_burger/models/item_carrinho.dart';
import 'package:garagem_burger/models/localizacao.dart';
import 'package:garagem_burger/models/produto.dart';
import 'package:google_fonts/google_fonts.dart';

enum TipoCard {
  cartao,
  localizacao,
  itemCarrinho,
  lanche,
}

class CardDismissible extends StatelessWidget {
  final Object item;
  final TipoCard tipoCard;
  final Function()? editar;
  final Function(String id) remover;
  final Function(String id)? favoritar;
  String id = '';
  String title = '';
  String subtitle = '';
  String? leadingImage;
  BoxFit? fit;
  bool? isFavorite;
  int? qntItens;
  double? width;

  CardDismissible({
    Key? key,
    this.favoritar,
    this.editar,
    required this.remover,
    required this.item,
    required this.tipoCard,
  }) : super(key: key);

  Future<bool?> _confirmRemove(context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => PopupDialog(
        titulo: 'Confirmar exclusão',
        descricao: 'Tem certeza que deseja excluir esse item da lista?',
        onPressedYesOption: () => Navigator.of(context).pop(true),
        onPressedNoOption: () => Navigator.of(context).pop(false),
      ),
    );
  }

  void _initItem(BuildContext context) {
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
        title =
            '${tempItem.rua}, ${tempItem.numero.toString()} - ${tempItem.bairro}'
            '\n${tempItem.cidade}, ${tempItem.estado}';
        subtitle = tempItem.descricao ?? '';
        leadingImage = null;
        isFavorite = tempItem.favorite;
        width = MediaQuery.of(context).size.width * 0.75;
        break;

      case TipoCard.itemCarrinho:
        final tempItem = item as ItemCarrinho;
        id = tempItem.produto.id;
        title = tempItem.produto.nome;
        subtitle = 'R\$ ${tempItem.produto.preco.toStringAsFixed(2)}';
        leadingImage = 'images/hamburguer.jpg';
        fit = BoxFit.cover;
        qntItens = tempItem.quantidade;
        width = MediaQuery.of(context).size.width * 0.50;
        break;

      case TipoCard.lanche:
        final tempItem = item as Produto;
        id = tempItem.id;
        title = tempItem.nome;
        subtitle = 'R\$ ${tempItem.preco.toStringAsFixed(2)}';
        leadingImage = 'images/hamburguer.jpg';
        fit = BoxFit.cover;
        width = MediaQuery.of(context).size.width * 0.50;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _initItem(context);

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
      onDismissed: (_) => remover(id),
      confirmDismiss: (_) => _confirmRemove(context),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          top: 8,
        ),
        child: GestureDetector(
          onTap: editar,
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
                  /*
                    * Leading (Imagem)
                    */
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
                  /*
                  * Title e Subtitle
                  */
                  Container(
                    padding: const EdgeInsets.all(12),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        /*
                        * Title
                        */
                        Text(
                          title, // max: 27 caracteres
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        /*
                        * Subtitle
                        */
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
                  /*
                  * Trailing (Marcar preferencial / Favoritar)
                  */
                  if (favoritar != null)
                    IconButton(
                      onPressed: () => favoritar!(id),
                      icon: (isFavorite!)
                          ? Icon(
                              Icons.star,
                              color: Theme.of(context).backgroundColor,
                            )
                          : const Icon(Icons.star_border_outlined),
                    ),
                  /*
                  * Trailing (quantidade de itens do carrinho)
                  */
                  if (qntItens != null)
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