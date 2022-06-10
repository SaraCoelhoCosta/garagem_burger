import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_text.dart';

class EmptyPage extends StatelessWidget {
  final String pageName;
  final IconData icon;
  final String titulo;
  final String subtitulo;
  final String rodape;
  final Function() switchPage;

  const EmptyPage({
    Key? key,
    required this.pageName,
    required this.icon,
    required this.titulo,
    required this.subtitulo,
    required this.rodape,
    required this.switchPage,
  }) : super(key: key);

  @override
  String toStringShort() => pageName;

  @override
  Widget build(BuildContext context) {
    // Altura total da tela, subtraindo as alturas da appBar e bottomBar
    final availableHeight = MediaQuery.of(context).size.height -
        (Scaffold.of(context).appBarMaxHeight ?? 0) -
        kBottomNavigationBarHeight;

    return Padding(
      padding: EdgeInsets.only(
        top: availableHeight * 0.10,
        bottom: availableHeight * 0.03,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: availableHeight * 0.30),
          TextButton(
            onPressed: switchPage,
            child: CustomText(
              titulo,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              textAlign: TextAlign.center,
            ),
          ),
          CustomText(
            subtitulo,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          CustomText(
            rodape,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
