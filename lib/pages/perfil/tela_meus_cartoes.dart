import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_dismissible.dart';
import 'package:garagem_burger/pages/cartoes/tela_alterar_cartao.dart';
import 'package:garagem_burger/pages/cartoes/tela_novo_cartao.dart';
import 'package:garagem_burger/pages/tela_vazia.dart';
import 'package:garagem_burger/providers/provider_cartao.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaMeusCartoes extends StatelessWidget {
  const TelaMeusCartoes({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Meus Cartões';

  Widget _buildTela(BuildContext context) {
    final provider = Provider.of<ProviderCartao>(
      context,
      listen: false,
    );
    return ListView(
      children: [
        Column(
          children: provider.listaCartoes
              .map((cartao) => CardDismissible(
                    tipoCard: TipoCard.cartao,
                    item: cartao,
                    editar: () => Navigator.of(context).pushNamed(
                      Rotas.main,
                      arguments: {
                        'index': 3,
                        'page': const TelaAlterarCartao(),
                        'button': null,
                      },
                    ),
                    favoritar: (id) => provider.selectFavorite(id),
                    remover: (id) => provider.removeCartao(id),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTelaVazia(BuildContext context) {
    return TelaVazia(
      pageName: 'Meus cartões',
      icon: Icons.credit_card,
      titulo: 'Adicionar novo cartão',
      subtitulo: 'Você ainda não possui um cartão cadastrado.',
      rodape: '',
      navigator: () => Navigator.of(context).pushNamed(
        Rotas.main,
        arguments: {
          'index': 3,
          'page': const TelaNovoCartao(),
          'button': null,
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCartao>(context);
    return (provider.qntCartoes == 0)
        ? _buildTelaVazia(context)
        : _buildTela(context);
  }
}
