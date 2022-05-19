import 'package:flutter/material.dart';

class CardIngrediente extends StatelessWidget {
  final String urlImage;
  final String text;
  final double imageRatioWidth;
  final double textRatioWidth;
  final double ratioWidth;

  const CardIngrediente({
    Key? key,
    required this.urlImage,
    required this.text,
    this.imageRatioWidth = 0.50,
    this.textRatioWidth = 0.45,
    this.ratioWidth = 0.45,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Altura total da tela, subtraindo a altura da appBar
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight!;

    return Card(
      // margin: const EdgeInsets.all(0),
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        height: availableHeight * 0.15,
        width: MediaQuery.of(context).size.width * ratioWidth,
        child: LayoutBuilder(builder: (ctx, constraints) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*
              * Imagem
              */
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: AssetImage(urlImage),
                    fit: BoxFit.contain,
                  ),
                ),
                width: constraints.maxWidth * imageRatioWidth,
              ),
              /*
              * Texto
              */
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                width: constraints.maxWidth * textRatioWidth,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
