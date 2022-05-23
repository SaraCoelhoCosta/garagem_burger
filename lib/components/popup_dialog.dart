import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/custom_text.dart';

class PopupDialog extends StatelessWidget {
  final String titulo;
  final String? descricao;
  final String yesLabel;
  final String noLabel;
  final bool isPassword;
  final void Function()? onPressedNoOption;
  final void Function()? onPressedYesOption;

  const PopupDialog({
    Key? key,
    required this.titulo,
    this.descricao,
    this.isPassword = false,
    this.onPressedNoOption,
    this.onPressedYesOption,
    this.yesLabel = 'Sim',
    this.noLabel = 'Não',
  }) : super(key: key);

  Widget? buildContent() {
    if (isPassword) {
      return CustomText('$isPassword: botões de senha');
    } else if (descricao != null) {
      return CustomText(
        descricao!,
        textAlign: TextAlign.center,
      );
    } else {
      return null;
    }
  }

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
        titulo,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
      content: buildContent(),
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
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: onPressedNoOption,
              child: CustomText(
                noLabel,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
