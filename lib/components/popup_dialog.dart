import 'package:flutter/material.dart';

class PopupDialog extends StatelessWidget {
  final String titulo;
  final String descricao;
  final String yesLabel;
  final String noLabel;
  final void Function()? onPressedNoOption;
  final void Function()? onPressedYesOption;

  const PopupDialog({
    Key? key,
    required this.titulo,
    this.descricao = '',
    this.onPressedNoOption,
    this.onPressedYesOption,
    this.yesLabel = 'Sim',
    this.noLabel = 'Não',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        titulo,
        style: const TextStyle(color: Colors.red),
      ),
      content: Text(descricao),
      actions: <Widget>[
        MaterialButton(
          elevation: 5.0,
          child: Text(noLabel),
          onPressed: onPressedNoOption,
        ),
        MaterialButton(
          elevation: 5.0,
          child: Text(
            yesLabel,
            style: const TextStyle(color: Colors.red),
          ),
          onPressed: onPressedYesOption,
        ),
      ],
    );
  }
}
