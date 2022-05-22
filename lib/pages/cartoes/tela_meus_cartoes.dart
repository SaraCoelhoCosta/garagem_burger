import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_dismissible.dart';
import 'package:garagem_burger/controllers/provider_cartoes.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/pages/cartoes/tela_alterar_cartao.dart';
import 'package:garagem_burger/pages/cartoes/tela_novo_cartao.dart';
import 'package:garagem_burger/pages/tela_vazia.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaMeusCartoes extends StatelessWidget {
  const TelaMeusCartoes({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Meus Cartões';

  @override
  Widget build(BuildContext context) {
    final pvdCartao = Provider.of<ProviderCartoes>(context);
    final pvdUsuario = Provider.of<ProviderUsuario>(context);
    if ((pvdCartao.emptyList)) {
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
    } else {
      return ListView(
        children: [
          Column(
            children: pvdCartao.cartoes.values.map((cartao) {
              return CardDismissible(
                tipoCard: TipoCard.cartao,
                item: cartao,
                editar: () => Navigator.of(context).pushNamed(
                  Rotas.main,
                  arguments: {
                    'index': 3,
                    'page': TelaAlterarCartao(cartao),
                    'button': null,
                  },
                ),
                favoritar: (id) {
                  pvdCartao.changeFavorite(pvdUsuario.usuario, id);
                },
                remover: (id) {
                  pvdCartao.deleteCartao(pvdUsuario.usuario, id);
                },
              );
            }).toList(),
          ),
        ],
      );
    }
  }
}
