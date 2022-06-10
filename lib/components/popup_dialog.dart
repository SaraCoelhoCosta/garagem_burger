import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_button.dart';
import 'package:garagem_burger/components/custom_text.dart';

class PopupDialog extends StatefulWidget {
  final String titulo;
  final String? descricao;
  final String yesLabel;
  final String noLabel;
  final bool isPassword;
  final bool isTextField;
  final String? titleTextField;
  final void Function()? onPressedNoOption;
  final void Function()? onPressedYesOption;

  const PopupDialog({
    Key? key,
    required this.titulo,
    this.descricao,
    this.isPassword = false,
    this.isTextField = false,
    this.onPressedNoOption,
    this.onPressedYesOption,
    this.yesLabel = 'Sim',
    this.noLabel = 'Não',
    this.titleTextField,
  }) : super(key: key);

  @override
  State<PopupDialog> createState() => _PopupDialogState();
}

class _PopupDialogState extends State<PopupDialog> {
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
      title: CustomText(
        widget.titulo,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
      content: CustomText(
        widget.descricao ?? '',
        textAlign: TextAlign.center,
      ),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CustomButton(
                onPressed: widget.onPressedYesOption,
                labelText: widget.yesLabel,
                externalPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.15,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: widget.onPressedNoOption,
              child: CustomText(
                widget.noLabel,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
