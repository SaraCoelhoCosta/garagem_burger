import 'package:flutter/material.dart';
import 'package:garagem_burger/components/barra_inferior.dart';
import 'package:garagem_burger/pages/carrinho/tela_carrinho.dart';
import 'package:garagem_burger/pages/menu/tela_menu.dart';
import 'package:garagem_burger/pages/meus_lanches/tela_meus_lanches.dart';
import 'package:garagem_burger/pages/perfil/tela_perfil.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int currentIndex = 0;
  Widget currentPage = const TelaMenu();
  bool updatedPage = true;

  static const _widgets = [
    TelaMenu(),
    TelaMeusLanches(),
    TelaCarrinho(),
    TelaPerfil(),
  ];

  _switchTab(int index) {
    setState(() {
      currentIndex = index;
      currentPage = _widgets.elementAt(currentIndex);

      // Limpar as rotas anteriores
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Rotas.main,
          (_) => false,
          arguments: [currentIndex, currentPage],
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!updatedPage) {
      List propriedades = ModalRoute.of(context)?.settings.arguments as List;
      currentIndex = propriedades.elementAt(0) as int;
      currentPage = propriedades.elementAt(1) as Widget;
      updatedPage = true;
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
      ),
      body: currentPage,
      bottomNavigationBar: BarraInferior(
        currentIndex: currentIndex,
        onTap: _switchTab,
      ),
    );
  }
}
