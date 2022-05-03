import 'package:flutter/material.dart';
import 'package:garagem_burger/models/item_carrinho.dart';
import 'package:garagem_burger/providers/provider_carrinho.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CardProdutoCar extends StatelessWidget {
  final ItemCarrinho itemCarrinho;

  const CardProdutoCar(
    this.itemCarrinho, {
    Key? key,
  }) : super(key: key);

  Future removerProduto(context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Remover produto',
          style: TextStyle(color: Colors.red),
        ),
        content: const Text('Deseja excluir o produto do carrinho?'),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: const Text(
              'Não',
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          MaterialButton(
            elevation: 5.0,
            child: const Text(
              'Sim',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<ProviderCarrinho>(
                context,
                listen: false,
              ).removeItemCarrinho(itemCarrinho.produto.id);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        top: 10.0,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            Rotas.produto,
            arguments: itemCarrinho.produto,
          );
        },
        child: Card(
          elevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Leading (Image)
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    image: DecorationImage(
                      image: AssetImage('images/hamburguer.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: MediaQuery.of(context).size.height * 0.15,
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
      
                // Title e subtitle
                Container(
                  padding: const EdgeInsets.all(12),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.height * 0.20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title
                      Text(
                        itemCarrinho.produto.nome, // max: 27 caracteres
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Subtitle
                      Text(
                        'R\$ ${itemCarrinho.produto.preco.toStringAsFixed(2)}',
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
                
                Row(
                  children: [
                    // Quantidade de produtos
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).backgroundColor,
                      ),
                      constraints: const BoxConstraints(
                        minHeight: 25,
                        minWidth: 25,
                      ),
                      child: Text(
                        '${itemCarrinho.quantidade}x',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oxygen(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
      
                    // Os 3 pontinhos
                    PopupMenuButton(
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                            child: const ListTile(
                              leading: Icon(Icons.create),
                              title: Text('Editar'),
                            ),
                            onTap: () {}),
                        PopupMenuItem(
                          child: const ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Excluir'),
                          ),
                          onTap: () {
                            Future.delayed(
                              const Duration(seconds: 0),
                              () => removerProduto(context),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
