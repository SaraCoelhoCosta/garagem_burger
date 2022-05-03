import 'package:flutter/material.dart';
import 'package:garagem_burger/models/cartao.dart';
import 'package:garagem_burger/pages/cartoes/tela_alterar_cartao.dart';
import 'package:garagem_burger/providers/provider_cartao.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CardCartao extends StatelessWidget {
  final Cartao cartao;

  const CardCartao({
    Key? key,
    required this.cartao,
  }) : super(key: key);

  Future excluirCartao(context) {
    final provider = Provider.of<ProviderCartao>(
      context,
      listen: false,
    );
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Excluir cartão',
          style: TextStyle(color: Colors.red),
        ),
        content: const Text('Deseja excluir o cartão?'),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: const Text('Sim'),
            onPressed: () {
              provider.removeCartao(cartao);
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
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 5.0,
            top: 7,
            bottom: 10,
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Image.asset('images/cartao1.jpg'),
            ),
            title: Text(
              'Meu cartão 1',
              style: GoogleFonts.oxygen(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              cartao.cardNumber + '\n Vencimento: 10/22',
              style: GoogleFonts.oxygen(
                fontSize: 20.0,
              ),
            ),
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
                    Future.delayed(
                      const Duration(seconds: 0),
                      () => Navigator.of(context).pushNamed(
                        Rotas.main,
                        arguments: [3, const TelaAlterarCartao()],
                      ),
                    );
                  },
                ),
                PopupMenuItem(
                  child: const ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Excluir'),
                  ),
                  onTap: () {
                    Future.delayed(
                      const Duration(seconds: 0),
                      () => excluirCartao(context),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
