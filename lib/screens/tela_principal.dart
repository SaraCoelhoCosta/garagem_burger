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

  int indexWidget = 0;

  static const _widgets = [
    {'titulo': 'Menu', 'tela': TelaMenu()},
    {'titulo': 'Meus Lanches', 'tela': TelaMeusLanches()},
    {'titulo': 'Carrinho', 'tela': TelaCarrinho()},
    {'titulo': 'Perfil', 'tela': TelaPerfil()},
  ];

  _alterarAba(int index){
    setState(() {
      indexWidget = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffed80b),
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
         _widgets.elementAt(indexWidget)['titulo'].toString(),
          style: GoogleFonts.keaniaOne(
            fontSize: 26.0,
          ),
        ),
      ),

      body: _widgets.elementAt(indexWidget)['tela'] as Widget,

      bottomNavigationBar: BarraInferior(
        currentIndex: indexWidget,
        onTap: _alterarAba,
      ),
    );
  }
}
