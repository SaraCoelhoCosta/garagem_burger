import 'package:flutter/material.dart';

class PopupDialog extends StatelessWidget {
  final String titulo;
  final String descricao;
  final void Function()? onPressedNoOption;
  final void Function()? onPressedYesOption;

  const PopupDialog({
    Key? key,
    required this.titulo,
    required this.descricao,
    this.onPressedNoOption,
    this.onPressedYesOption,
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
          child: const Text('Não'),
          onPressed: onPressedNoOption,
        ),
        MaterialButton(
          elevation: 5.0,
          child: const Text(
            'Sim',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: onPressedYesOption,
        ),
      ],
    );
  }
}
