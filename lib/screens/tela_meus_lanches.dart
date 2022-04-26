import 'package:flutter/material.dart';
import 'package:garagem_burger/screens/components/card_lanche.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaMeusLanches extends StatelessWidget {
  final bool telaVazia;

  const TelaMeusLanches({Key? key, this.telaVazia = false}) : super(key: key);

  @override
  String toStringShort() => 'Meus Lanches';

  Future excluirLanche(context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            const Text('Excluir lanche', style: TextStyle(color: Colors.red)),
        content: const Text('Deseja excluir todos os seus lanches?'),
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

  Widget telaMeusLanchesVazia() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            const Icon(Icons.fastfood, size: 100),
            const SizedBox(height: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 150,
                  width: 300,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'MONTE SEU PRÓPRIO HAMBÚRGUER',
                      style: GoogleFonts.oxygen(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 60, bottom: 60, left: 50, right: 50),
                  child: Text(
                    'Você ainda não montou nenhum lanche.',
                    style: GoogleFonts.oxygen(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Text(
              'Dê um nome as suas criações, e elas aparecerão aqui.',
              style: GoogleFonts.oxygen(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20)
          ],
        ),
      ],
    );
  }

  Widget telaMeusLanches(context) {
    return ListView(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () {
                Future.delayed(
                  const Duration(seconds: 0),
                  () => excluirLanche(context),
                );
              },
              label: Text('Excluir todos os meus lanches',
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
        const SizedBox(height: 20),
        const CardLanche(text: 'X-Infarto de Sara'),
        const CardLanche(text: 'Morgana de Will'),
        const CardLanche(text: 'Big Tentação de Lara'),
        const CardLanche(text: 'X-Infarto de Sara'),
        const CardLanche(text: 'Morgana de Will'),
        const CardLanche(text: 'Big Tentação de Lara'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (telaVazia) ? telaMeusLanchesVazia() : telaMeusLanches(context));
  }
}
