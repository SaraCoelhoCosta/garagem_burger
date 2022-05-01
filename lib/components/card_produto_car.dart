import 'package:flutter/material.dart';

class CardProdutoCar extends StatelessWidget {
  const CardProdutoCar({
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
          padding: const EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  image: DecorationImage(
                      image: AssetImage('images/hamburguer.jpg'),
                      fit: BoxFit.cover),
                ),
                width: 120,
                height: 120,
                // child: Image.asset('images/hamburguer.jpg'),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Combo fofo \n\nR\$ 34,00',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(
                width: 40,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Text(
                  '1x',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: PopupMenuButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
ListTile(
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            child: Image.asset('images/hamburguer.jpg'),
          ),
          title: Text('',
            style: GoogleFonts.oxygen(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('',
            style: GoogleFonts.oxygen(
              fontSize: 20.0,
            ),
          ),
          contentPadding: const EdgeInsets.all(6),
          trailing: PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Carrinho'),
                ),
                onTap: () {
                  Future.delayed(
                    const Duration(seconds: 0),
                    () => removerProduto(context),
                  );
                },
              ),
              PopupMenuItem(
                  child: const ListTile(
                    leading: Icon(Icons.create),
                    title: Text('Editar'),
                  ),
                  onTap: () {
                  }),
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
        ),
*/