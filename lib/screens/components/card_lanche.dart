import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardLanche extends StatelessWidget {
  final String text;

  const CardLanche({
    Key? key,
    required this.text,
  }) : super(key: key);

  Future comprarLanche(context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar ao carrinho',
            style: TextStyle(color: Colors.green)),
        content: const Text('Lanche adicionado ao carrinho'),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future excluirLanche(context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            const Text('Excluir lanche', style: TextStyle(color: Colors.red)),
        content: const Text('Deseja excluir o lanche X-Infarto de Sara?'),
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
            child: const Text('Não', style: TextStyle(color: Colors.red)),
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
        child: ListTile(
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            child: Image.asset('images/hamburguer.jpg'),
          ),
          title: Text(
            text,
            style: GoogleFonts.oxygen(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'R\$ 20.00',
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
                    () => comprarLanche(context),
                  );
                },
              ),
              PopupMenuItem(
                  child: const ListTile(
                    leading: Icon(Icons.create),
                    title: Text('Editar'),
                  ),
                  onTap: () {
                    //Navigator para a tela de editar lanche
                  }),
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Excluir'),
                ),
                onTap: () {
                  Future.delayed(
                    const Duration(seconds: 0),
                    () => excluirLanche(context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
