import 'package:flutter/material.dart';
import 'package:garagem_burger/models/localizacao.dart';
import 'package:garagem_burger/providers/provider_localizacoes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CardEndereco extends StatelessWidget {
  final Localizacao localizacao;

  const CardEndereco({
    Key? key,
    required this.localizacao,
  }) : super(key: key);

  Future excluirLanche(context) {
    final provider = Provider.of<ProviderLocalizacoes>(
      context,
      listen: false,
    );
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Excluir endereço',
          style: TextStyle(color: Colors.red),
        ),
        content: const Text('Deseja excluir o endereço?'),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: const Text('Sim'),
            onPressed: () {
              provider.removeLocalizacao(localizacao.id);
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
        child: ListTile(
          title: Text(
            '${localizacao.rua}, ${localizacao.numero.toString()} - '
            '${localizacao.bairro}\n${localizacao.cidade}, ${localizacao.estado}',
            style: GoogleFonts.oxygen(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            localizacao.descricao!,
            style: GoogleFonts.oxygen(
              fontSize: 20.0,
            ),
          ),
          contentPadding: const EdgeInsets.all(6),
          trailing: PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  title: Text('Preferencial'),
                ),
                onTap: () {},
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
