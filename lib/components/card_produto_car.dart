import 'package:flutter/material.dart';
import 'package:garagem_burger/models/item_carrinho.dart';
import 'package:garagem_burger/providers/provider_carrinho.dart';
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
            child: const Text('Sim'),
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<ProviderCarrinho>(
                context,
                listen: false,
              ).removeItemCarrinho(itemCarrinho.produto.id);
            },
          ),
          MaterialButton(
            elevation: 5.0,
            child: const Text(
              'Não',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
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
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
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
                // width: 120,
                // height: 120,
                width: MediaQuery.of(context).size.height * 0.15,
                height: MediaQuery.of(context).size.height * 0.15,
                // child: Image.asset('images/hamburguer.jpg'),
              ),

              const SizedBox(width: 20),

              // Title e subtitle
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Text(
                    itemCarrinho.produto.nome,
                    softWrap: true,
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

              const Spacer(),

              // Quantidade de produtos
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  '${itemCarrinho.quantidade}x',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
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
        ),
      ),
    );
  }
}
