import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_category.dart';

class CategoryGrid extends StatelessWidget {
  final bool isIngredients;
  final Function()? showIngredients;
  final Function()? showPao;
  final Function()? showCarne;

  const CategoryGrid({
    Key? key,
    required this.isIngredients,
    this.showIngredients,
    this.showPao,
    this.showCarne,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /*
        * Ingredientes do hamburguer
        */
        if (!isIngredients)
          CardCategory(
            onTap: showIngredients,
            urlImage: 'images/ingredientes.png',
            text: 'Ingredientes do Hambúrguer',
            imageRatioWidth: 0.30,
            textRatioWidth: 0.65,
            ratioWidth: 0.92,
          ),
        /*
        * Pão e carne
        */
        if (!isIngredients)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CardCategory(
                onTap: showPao,
                urlImage: 'images/pao.png',
                text: 'Pão',
              ),
              CardCategory(
                onTap: showCarne,
                urlImage: 'images/carne.jpg',
                text: 'Carne',
              ),
            ],
          ),
        /*
        * Frutas, verduras e legumes
        */
        if (isIngredients)
          const CardCategory(
            urlImage: 'images/pao.png',
            text: 'Frutas, verduras e legumes',
            subtitle: 'R\$ 1,40',
            imageRatioWidth: 0.30,
            textRatioWidth: 0.65,
            ratioWidth: 0.92,
          ),
        /*
        * Queijos e cebolas
        */
        if (isIngredients)
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CardCategory(
                urlImage: 'images/pao.png',
                text: 'Queijos',
                subtitle: 'R\$ 1,40',
              ),
              CardCategory(
                urlImage: 'images/carne.jpg',
                text: 'Cebolas',
                subtitle: 'R\$ 1,40',
              ),
            ],
          ),
        /*
        * Molhos e Outros
        */
        if (isIngredients)
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CardCategory(
                urlImage: 'images/pao.png',
                text: 'Molhos',
                subtitle: 'R\$ 1,40',
              ),
              CardCategory(
                urlImage: 'images/carne.jpg',
                text: 'Outros',
                subtitle: 'R\$ 1,40',
              ),
            ],
          ),
      ],
    );
  }
}
