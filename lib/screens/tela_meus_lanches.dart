import 'package:flutter/material.dart';
import 'package:garagem_burger/rotas.dart';
import 'package:garagem_burger/screens/components/card_lanche.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaMeusLanches extends StatelessWidget {
  const TelaMeusLanches({Key? key}) : super(key: key);

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
              Rotas.nvgSemRetorno(
                context: context,
                rota: Rotas.telaVazia,
                argumentos: {
                  'page': 'Meus Lanches',
                  'rota': Rotas.montarHamburguer,
                  'icon': Icons.fastfood,
                  'titulo': 'MONTE SEU PRÓPRIO HAMBÚRGUER',
                  'subtitulo': 'Você ainda não montou nenhum lanche.',
                  'rodape': 'Dê um nome as suas criações, e elas aparecerão aqui.',
                },
              );
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
}
