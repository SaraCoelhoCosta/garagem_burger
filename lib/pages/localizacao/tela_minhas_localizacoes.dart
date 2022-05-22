import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_dismissible.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
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

  @override
  Widget build(BuildContext context) {
    final pvdLocal = Provider.of<ProviderLocalizacoes>(context);
    final pvdUsuario = Provider.of<ProviderUsuario>(context);
    if ((pvdLocal.emptyList)) {
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
    } else {
      return ListView(
        children: [
          Column(
            children: pvdLocal.locations.values.map(
              (localizacao) {
                return CardDismissible(
                  tipoCard: TipoCard.localizacao,
                  item: localizacao,
                  editar: () => Navigator.of(context).pushNamed(
                    Rotas.main,
                    arguments: {
                      'index': 3,
                      'page': TelaAlterarLocalizacao(localizacao),
                      'button': null,
                    },
                  ),
                  remover: (id) {
                    pvdLocal.deleteLocation(pvdUsuario.usuario, id);
                  },
                  favoritar: (id) {
                    pvdLocal.changeFavorite(pvdUsuario.usuario, id);
                  },
                );
              },
            ).toList(),
          ),
        ],
      );
    }
  }
}
