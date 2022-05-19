import 'package:flutter/material.dart';

class CardIngrediente extends StatelessWidget {
  final String urlImage;
  final String text;
  final String? subtitle;
  final double proportion;
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
    required this.proportion,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Altura total da tela, subtraindo as alturas do bottomBar
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight!;

    return Flexible(
      child: Card(
        // margin: const EdgeInsets.all(0),
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(
            width: 0.3,
            color: Colors.grey,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(5),
          height: availableHeight * proportion,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    if (subtitle != null)
                      const Text(
                        '+R\$ 1,40',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
