import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/models/ingrediente.dart';

class CardIngredient extends StatelessWidget {
  final Ingrediente ingredient;
  final int count;
  final Function()? addItem;
  final Function()? removeItem;

  const CardIngredient({
    Key? key,
    required this.ingredient,
    required this.count,
    this.addItem,
    this.removeItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Altura total da tela, subtraindo a altura da appBar
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight!;
    final deviceWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(builder: (ctx, constraints) {
      return SizedBox(
        height: availableHeight * 0.17,
        child: Card(
          elevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*
              * Leading (Imagem)
              */
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
                    image: ingredient.urlImage,
                    placeholder: 'images/placeholder-produto.jpg',
                    fit: BoxFit.cover,
                    placeholderFit: BoxFit.cover,
                  ),
                ),
                width: constraints.maxWidth * 0.30,
                height: double.infinity,
              ),
              /*
              * Tudo
              */
              Container(
                padding: const EdgeInsets.only(left: 12),
                width: constraints.maxWidth * 0.65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /*
                    * Title (Nome e Quantidade)
                    */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          ingredient.nome,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          height: deviceWidth * 0.07,
                          width: deviceWidth * 0.07,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).backgroundColor,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CustomText(
                              count.toString(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    /*
                    * Subtitle (Preço e botões)
                    */
                    Row(
                      children: [
                        CustomText(
                          '${ingredient.quantidade} '
                          '${ingredient.unidadeMedida}'
                          '\nR\$ ${ingredient.preco.toStringAsFixed(2)}',
                          color: Colors.grey,
                          textAlign: TextAlign.left,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 50,
                          child: Botao(
                            onPressed: removeItem,
                            icon: Icons.remove,
                            externalPadding: const EdgeInsets.only(right: 10),
                            internalPadding: EdgeInsets.zero,
                            iconSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: Botao(
                            onPressed: addItem,
                            icon: Icons.add,
                            internalPadding: EdgeInsets.zero,
                            iconSize: 20,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
