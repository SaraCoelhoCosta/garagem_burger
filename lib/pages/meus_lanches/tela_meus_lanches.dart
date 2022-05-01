import 'package:flutter/material.dart';
import 'package:garagem_burger/providers/provider_lanches.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:garagem_burger/components/card_lanche.dart';
import 'package:garagem_burger/components/popup_dialog.dart';
import 'package:garagem_burger/pages/tela_vazia.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TelaMeusLanches extends StatelessWidget {
  const TelaMeusLanches({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Meus Lanches';

  Future excluirLanche(context) {
    final provider = Provider.of<ProviderLanches>(
      context,
      listen: false,
    );
    return showDialog(
      context: context,
      builder: (context) {
        return PopupDialog(
          titulo: 'Excluir lanche',
          descricao: 'Deseja excluir todos os seus lanches?',
          onPressedYesOption: () {
            Navigator.of(context).pop();
            provider.clearAll();
          },
          onPressedNoOption: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Widget _buildTela(BuildContext context) {
    final meusLanches = Provider.of<ProviderLanches>(context).listaLanches;
    return ListView(
      children: [
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
        Column(
          children: meusLanches.map((lanche) {
            return CardLanche(lanche: lanche);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTelaVazia(BuildContext context) {
    return TelaVazia(
      pageName: 'Meus Lanches',
      icon: Icons.fastfood,
      titulo: 'MONTE SEU PRÓPRIO HAMBÚRGUER',
      subtitulo: 'Você ainda não montou nenhum lanche.',
      rodape: 'Dê um nome as suas criações, e elas aparecerão aqui.',
      navigator: () => Navigator.of(context).pushNamed(
        Rotas.montarHamburguer,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderLanches>(context);
    return (provider.qntLanches == 0) ? _buildTelaVazia(context) : _buildTela(context);
  }
}
