import 'package:flutter/material.dart';
import 'package:garagem_burger/components/app_bar_button.dart';
import 'package:garagem_burger/components/barra_inferior.dart';
import 'package:garagem_burger/pages/carrinho/tela_carrinho.dart';
import 'package:garagem_burger/pages/menu/tela_menu.dart';
import 'package:garagem_burger/pages/meus_lanches/tela_meus_lanches.dart';
import 'package:garagem_burger/pages/perfil/tela_perfil.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaPrincipal extends StatefulWidget {
  final bool loginUpdatedPage;

  const TelaPrincipal({Key? key, this.loginUpdatedPage = false})
      : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  AppBarButton? currentButton;
  int currentIndex = 0;
  Widget currentPage = const TelaMenu();
  bool routeUpdatedPage = false;

  static const _widgets = [
    TelaMenu(),
    TelaMeusLanches(),
    TelaCarrinho(),
    TelaPerfil(),
  ];

  static final _buttons = [
    null,
    const AppBarButton(
      icon: Icons.delete,
      tipoFuncao: TipoFuncao.limparLanches,
    ),
    const AppBarButton(
      icon: Icons.delete,
      tipoFuncao: TipoFuncao.limparCarrinho,
    ),
    null,
  ];

  _switchTab(int index) {
    setState(() {
      currentIndex = index;
      currentPage = _widgets.elementAt(currentIndex);
      currentButton = _buttons.elementAt(currentIndex);

      // Limpar as rotas anteriores
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Rotas.main,
          (_) => false,
          arguments: {
            'index': currentIndex,
            'page': currentPage,
            'button': currentButton,
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.loginUpdatedPage && !routeUpdatedPage) {
      final properties =
          ModalRoute.of(context)?.settings.arguments as Map<String, Object?>;
      currentIndex = properties['index'] as int;
      currentPage = properties['page'] as Widget;
      currentButton = properties['button'] as AppBarButton?;
      routeUpdatedPage = true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffed80b),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          currentPage.toStringShort(),
          style: GoogleFonts.keaniaOne(
            fontSize: 26.0,
          ),
        ),
        actions: [if (currentButton != null) currentButton as Widget],
      ),
      body: currentPage,
      bottomNavigationBar: BarraInferior(
        currentIndex: currentIndex,
        onTap: _switchTab,
      ),
    );
  }
}
