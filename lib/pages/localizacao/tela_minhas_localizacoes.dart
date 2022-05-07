import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_dismissible.dart';
import 'package:garagem_burger/pages/localizacao/tela_alterar_localizacao.dart';
import 'package:garagem_burger/pages/localizacao/tela_nova_localizacao.dart';
import 'package:garagem_burger/pages/tela_vazia.dart';
import 'package:garagem_burger/controllers/provider_localizacoes.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaMinhasLocalizacoes extends StatelessWidget {
  const TelaMinhasLocalizacoes({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Minhas Localizações';

  Widget _buildTela(BuildContext context) {
    final provider = Provider.of<ProviderLocalizacoes>(
      context,
      listen: false,
    );
    return ListView(
      children: [
        Column(
          children: provider.listaLocalizacoes
              .map((localizacao) => CardDismissible(
                    tipoCard: TipoCard.localizacao,
                    item: localizacao,
                    editar: () => Navigator.of(context).pushNamed(
                      Rotas.main,
                      arguments: {
                        'index': 3,
                        'page': const TelaAlterarLocalizacao(),
                        'button': null,
                      },
                    ),
                    favoritar: (id) => provider.selectFavorite(id),
                    remover: (id) => provider.removeLocalizacao(id),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTelaVazia(BuildContext context) {
    return TelaVazia(
      pageName: 'Minha Localizações',
      icon: Icons.location_on_outlined,
      titulo: 'Adicionar novo endereço',
      subtitulo: 'Você ainda não possui endereço cadastrado.',
      rodape: 'Decida onde quer matar sua fome.',
      navigator: () => Navigator.of(context).pushNamed(
        Rotas.main,
        arguments: {
          'index': 3,
          'page': const TelaNovaLocalizacao(),
          'button': null,
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderLocalizacoes>(context);
    return (provider.qntLocalizacoes == 0)
        ? _buildTelaVazia(context)
        : _buildTela(context);
  }
}
