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
      titlePadding: descricao == null
          ? EdgeInsets.only(
              top: 24,
              bottom: 10,
              left: MediaQuery.of(context).size.width * 0.25,
              right: MediaQuery.of(context).size.width * 0.25)
          : EdgeInsets.only(
              top: 24,
              bottom: 20,
              right: MediaQuery.of(context).size.width * 0.25,
              left: MediaQuery.of(context).size.width * 0.25),
      title: Flexible(
        child: SizedBox(
          child: Text(
            titulo,
            style: GoogleFonts.oxygen(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      content: descricao != null
          ? Flexible(
              child: Text(
                descricao!,
                textAlign: TextAlign.center,
              ),
            )
          : const SizedBox(),
      actions: <Widget>[
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 120,
                  child: Botao(
                    onPressed: onPressedYesOption,
                    labelText: yesLabel,
                    // internalPadding: const EdgeInsets.symmetric(horizontal: ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
