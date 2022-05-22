import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_text.dart';

class CardMeatOption extends StatelessWidget {
  final String text;
  final double imageRatioWidth;
  final double textRatioWidth;
  final double ratioWidth;
  final bool isSelected;
  final Function() onTap;

  const CardMeatOption({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.imageRatioWidth = 0.50,
    this.textRatioWidth = 0.45,
    this.ratioWidth = 0.45,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Altura total da tela, subtraindo as alturas da appBar e bottomBar
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight!;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            width: (isSelected) ? 1.0 : 0.3,
            color: (isSelected) ? Colors.black : Colors.grey,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          height: availableHeight * 0.10,
          width: MediaQuery.of(context).size.width * ratioWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
