import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:google_fonts/google_fonts.dart';

class PopupDialog extends StatelessWidget {
  final String titulo;
  final String? descricao;
  final String yesLabel;
  final String noLabel;
  final void Function()? onPressedNoOption;
  final void Function()? onPressedYesOption;

  const PopupDialog({
    Key? key,
    required this.titulo,
    this.descricao,
    this.onPressedNoOption,
    this.onPressedYesOption,
    this.yesLabel = 'Sim',
    this.noLabel = 'Não',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 70),
      // padd
      title: Text(
        titulo,
        style: GoogleFonts.oxygen(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: descricao != null
          ? Text(
            descricao!,
            textAlign: TextAlign.center,
            style: GoogleFonts.oxygen(
              color: Colors.black,
              fontSize: 18,
            ),
          )
          : null,
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Botao(
                onPressed: onPressedYesOption,
                labelText: yesLabel,
                externalPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.20,
                ),
              ),
            ),
            TextButton(
              onPressed: onPressedNoOption,
              child: Text(
                noLabel,
                style: GoogleFonts.oxygen(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
