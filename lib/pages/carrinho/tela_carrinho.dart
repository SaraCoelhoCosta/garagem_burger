import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao_amarelo.dart';
import 'package:garagem_burger/components/card_produto_car.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaCarrinho extends StatelessWidget {
  const TelaCarrinho({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Endereço';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () {},
              label: Text('Limpar carrinho',
                  style: GoogleFonts.oxygen(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.left),
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const CardProdutoCar(),
        const CardProdutoCar(),
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
                const Text(
                  '\nTotal ------------------------------ R\$ 88,00\n',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Dica: Clicando no ícone ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.create),
                    Text(
                      ' você pode editar a',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'quantidade ou configurar seu produto\n',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: BotaoAmarelo(
                      labelText: 'Efetuar pedido', onPressed: () {}),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
