import 'package:flutter/material.dart';
import 'package:garagem_burger/data/rotas.dart';
import 'package:garagem_burger/screens/components/card_lanche.dart';
import 'package:garagem_burger/screens/tela_vazia.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaMeusLanches extends StatefulWidget {
  const TelaMeusLanches({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Meus Lanches';

  @override
  State<TelaMeusLanches> createState() => _TelaMeusLanchesState();
}

class _TelaMeusLanchesState extends State<TelaMeusLanches> {
  bool emptyPage = false;

  void _switchBody(bool pageState) {
    setState(() {
      emptyPage = pageState;
    });
  }

  Future excluirLanche(context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Excluir lanche',
          style: TextStyle(color: Colors.red),
        ),
        content: const Text('Deseja excluir todos os seus lanches?'),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: const Text('Sim'),
            onPressed: () {
              Navigator.of(context).pop();
              _switchBody(true);
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

  Widget _buildTela(BuildContext context) {
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
 
  Widget _buildTelaVazia() {
    return const TelaVazia(
      pageName: 'Meus Lanches',
      icon: Icons.fastfood,
      rota: Rotas.montarHamburguer,
      titulo: 'MONTE SEU PRÓPRIO HAMBÚRGUER',
      subtitulo: 'Você ainda não montou nenhum lanche.',
      rodape: 'Dê um nome as suas criações, e elas aparecerão aqui.',
    );
  }

  @override
  Widget build(BuildContext context) {

    return (emptyPage) ? _buildTelaVazia() : _buildTela(context);
  }
}
