import 'package:flutter/material.dart';
import 'package:garagem_burger/screens/components/barra_inferior.dart';
import 'package:garagem_burger/screens/tela_carrinho.dart';
import 'package:garagem_burger/screens/tela_menu.dart';
import 'package:garagem_burger/screens/tela_meus_lanches.dart';
import 'package:garagem_burger/screens/perfil/tela_perfil.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaPrincipal extends StatefulWidget {

  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  int currentIndex = 0;
  Widget currentPage = const TelaMenu();
  bool attPage = false;

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

  @override
  Widget build(BuildContext context) {

    if(!attPage){
      List propriedades = ModalRoute.of(context)?.settings.arguments as List;
      currentIndex = propriedades.elementAt(0) as int;
      currentPage = propriedades.elementAt(1) as Widget;
      attPage = true;
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
