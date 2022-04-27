import 'package:flutter/material.dart';
import 'package:garagem_burger/screens/components/barra_inferior.dart';
import 'package:garagem_burger/screens/tela_carrinho.dart';
import 'package:garagem_burger/screens/tela_menu.dart';
import 'package:garagem_burger/screens/tela_meus_lanches.dart';
import 'package:garagem_burger/screens/telas_perfil/tela_perfil.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaPrincipal extends StatefulWidget {

  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  int currentIndex = 0;
  Widget currentPage = const TelaMenu();

  static const _widgets = [
    TelaMenu(),
    TelaMeusLanches(),
    TelaCarrinho(),
    TelaPerfil(),
  ];

  _switchTab(int index){
    setState(() {
      currentIndex = index;
      currentPage = _widgets.elementAt(currentIndex);
    });
  }

  // _switchBody(Widget page){
  //   setState(() {
  //     currentPage = page;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

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

      // body: Navigator(
      //   onGenerateRoute: (settings) {
      //     if (settings.name == Rotas.meusPedidos) {
      //       _switchBody(const TelaMeusPedidos());
      //     } else if (settings.name == Rotas.minhasLocalizacoes) {
      //       _switchBody(const TelaMinhasLocalizacoes());
      //     } else if (settings.name == Rotas.meusCartoes) {
      //       _switchBody(const TelaMeusCartoes());
      //     } else if (settings.name == Rotas.configuracoes) {
      //       _switchBody(const TelaConfiguracoes());
      //     } else if (settings.name == Rotas.produto) {
      //       _switchBody(const TelaProduto());
      //     }
      //     return MaterialPageRoute(builder: (_) => currentPage);
      //   },
      // ),

      bottomNavigationBar: BarraInferior(
        currentIndex: currentIndex,
        onTap: _switchTab,
      ),
    );
  }
}
