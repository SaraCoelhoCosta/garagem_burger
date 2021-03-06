import 'package:flutter/material.dart';
import 'package:garagem_burger/components/popup_dialog.dart';
import 'package:garagem_burger/pages/cartoes/tela_novo_cartao.dart';
import 'package:garagem_burger/pages/localizacao/tela_nova_localizacao.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:garagem_burger/controllers/provider_lanches.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:provider/provider.dart';

enum TipoFuncao {
  limparCarrinho,
  limparLanches,
  adicionarLocalizacao,
  adicionarCartao,
}

class AppBarButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final TipoFuncao tipoFuncao;

  const AppBarButton({
    Key? key,
    required this.tipoFuncao,
    this.icon = Icons.delete,
    this.color = Colors.black,
  }) : super(key: key);

  _onPressed(BuildContext context) {
    switch (tipoFuncao) {
      case TipoFuncao.limparCarrinho:
        _limpar(
          context,
          Provider.of<ProviderCarrinho>(
            context,
            listen: false,
          ),
        );
        break;

      case TipoFuncao.limparLanches:
        _limpar(
          context,
          Provider.of<ProviderLanches>(
            context,
            listen: false,
          ),
        );
        break;

      case TipoFuncao.adicionarLocalizacao:
        _adicionar(context, const TelaNovaLocalizacao());
        break;

      case TipoFuncao.adicionarCartao:
        _adicionar(context, const TelaNovoCartao());
        break;
    }
  }

  _limpar(BuildContext context, provider) {
    return showDialog(
      context: context,
      builder: (context) {
        return PopupDialog(
          titulo: 'Excluir tudo',
          descricao: 'Deseja excluir todos os itens da lista?',
          onPressedYesOption: () {
            Navigator.of(context).pop(true);
          },
          onPressedNoOption: () {
            Navigator.of(context).pop(false);
          },
        );
      },
    ).then((selectedYesOption) {
      if (selectedYesOption) {
        provider.clearAll();
      }
    });
  }

  _adicionar(BuildContext context, Widget page) {
    Navigator.of(context).pushNamed(
      Rotas.main,
      arguments: {
        'index': 3,
        'page': page,
        'button': null,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isInvisible;
    switch (tipoFuncao) {
      case TipoFuncao.limparCarrinho:
        isInvisible = Provider.of<ProviderCarrinho>(context).emptyList;
        break;

      case TipoFuncao.limparLanches:
        isInvisible = Provider.of<ProviderLanches>(context).emptyList;
        break;

      case TipoFuncao.adicionarLocalizacao:
        isInvisible = false;
        break;

      case TipoFuncao.adicionarCartao:
        isInvisible = false;
        break;
    }
    return Offstage(
      offstage: isInvisible,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: IconButton(
          icon: Icon(icon),
          color: color,
          onPressed: () => _onPressed(context),
        ),
      ),
    );
  }
}
