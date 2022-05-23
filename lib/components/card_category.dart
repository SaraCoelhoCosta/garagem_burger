import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_text.dart';

class CardCategory extends StatelessWidget {
  final String urlImage;
  final String text;
  final String? subtitle;
  final double imageRatioWidth;
  final double textRatioWidth;
  final double ratioWidth;
  final double ratioHeight;
  final int flex;
  final bool isNetworkImage;
  final bool isSelected;
  final Function()? onTap;

  const CardCategory({
    Key? key,
    required this.urlImage,
    required this.text,
    this.isNetworkImage = false,
    this.isSelected = false,
    this.flex = 1,
    this.ratioHeight = 0.15,
    this.imageRatioWidth = 0.50,
    this.textRatioWidth = 0.45,
    this.ratioWidth = 0.45,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight!;

    return Flexible(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
              width: isSelected ? 1.0 : 0.3,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(5),
            height: availableHeight * ratioHeight,
            width: MediaQuery.of(context).size.width * ratioWidth,
            child: LayoutBuilder(builder: (ctx, constraints) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /*
                  * Imagem
                  */
                  if (!isNetworkImage)
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
                  if (isNetworkImage)
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: FadeInImage.assetNetwork(
                          image: urlImage,
                          placeholder: 'images/pao.png',
                          fit: BoxFit.cover,
                          placeholderFit: BoxFit.cover,
                        ),
                      ),
                      width: constraints.maxWidth * imageRatioWidth,
                    ),
                  /*
                  * Title (Nome do ingrediente)
                  */
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        width: constraints.maxWidth * textRatioWidth,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CustomText(
                            text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      /*
                      * Subtitle (Preço)
                      */
                      if (subtitle != null)
                        const CustomText(
                          '+R\$ 1,40',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
