import 'package:flutter/material.dart';

class CardNome extends StatelessWidget {
  final String text;
  final double imageRatioWidth;
  final double textRatioWidth;
  final double ratioWidth;

  const CardNome({
    Key? key,
    required this.text,
    this.imageRatioWidth = 0.50,
    this.textRatioWidth = 0.45,
    this.ratioWidth = 0.45,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Altura total da tela, subtraindo as alturas da appBar e bottomBar
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight!;

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(
          width: 0.3,
          color: Colors.grey,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: availableHeight * 0.10,
        width: MediaQuery.of(context).size.width * ratioWidth,
        child: LayoutBuilder(builder: (ctx, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
