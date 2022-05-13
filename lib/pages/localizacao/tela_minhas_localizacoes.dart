import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_dismissible.dart';
import 'package:garagem_burger/models/localizacao.dart';
import 'package:garagem_burger/pages/localizacao/tela_alterar_localizacao.dart';
import 'package:garagem_burger/pages/localizacao/tela_nova_localizacao.dart';
import 'package:garagem_burger/pages/tela_vazia.dart';
import 'package:garagem_burger/controllers/provider_localizacoes.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaMinhasLocalizacoes extends StatefulWidget {
  const TelaMinhasLocalizacoes({Key? key}) : super(key: key);
  @override
  String toStringShort() => 'Minhas Localizações';

  @override
  State<TelaMinhasLocalizacoes> createState() => _TelaMinhasLocalizacoesState();
}

class _TelaMinhasLocalizacoesState extends State<TelaMinhasLocalizacoes> {
  Widget _buildTela(BuildContext context) {
    final provider = Provider.of<ProviderLocalizacoes>(context);

    return ListView(
      children: [
        Column(
          children: provider.localizacoesList
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
                    remover: (id) {
                      provider.removerLocalizacao(id as String);
                    },
                    //TODO: favoritar: (id) => provider.selectFavorite(id),
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
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(milliseconds: 100));
      },
      child: (provider.listaVazia)
          ? _buildTelaVazia(context)
          : _buildTela(context),
    );
  }
}
