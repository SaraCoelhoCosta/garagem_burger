import 'package:flutter/material.dart';
import 'package:garagem_burger/controllers/pages.dart';
import 'package:garagem_burger/pages/empty_page.dart';
import 'package:provider/provider.dart';

class LunchPage extends StatelessWidget {
  const LunchPage({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Meus Lanches';

  @override
  Widget build(BuildContext context) {
    final pvdPages = Provider.of<Pages>(context);
    return EmptyPage(
      pageName: 'Meus Lanches',
      icon: Icons.fastfood,
      titulo: 'MONTE SEU PRÓPRIO HAMBÚRGUER',
      subtitulo: 'Você ainda não montou nenhum lanche.',
      rodape: 'Dê um nome as suas criações, e elas aparecerão aqui.',
      switchPage: () {
        pvdPages.setCurrentIndex(0);
      },
    );
  }
}
