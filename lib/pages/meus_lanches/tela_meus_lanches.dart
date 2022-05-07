import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_dismissible.dart';
import 'package:garagem_burger/controllers/provider_lanches.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:garagem_burger/pages/tela_vazia.dart';
import 'package:provider/provider.dart';

class TelaMeusLanches extends StatelessWidget {
  const TelaMeusLanches({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Meus Lanches';

  Widget _buildTela(BuildContext context) {
    final provider = Provider.of<ProviderLanches>(context);
    return ListView(
      children: [
        Column(
          children: provider.listaLanches.map((lanche) {
            return CardDismissible(
              tipoCard: TipoCard.lanche,
              item: lanche,
              remover: (id) => provider.removeLanche(id),
              editar: () => Navigator.of(context).pushNamed(
                Rotas.produto,
                arguments: [true, lanche],
              ),
            );
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
    return (provider.qntLanches == 0)
        ? _buildTelaVazia(context)
        : _buildTela(context);
  }
}
