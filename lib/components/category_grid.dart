import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_ingrediente.dart';

class CategoryGrid extends StatelessWidget {
  final bool isIngredients;

  const CategoryGrid({
    Key? key,
    required this.isIngredients,
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
          const CardIngrediente(
            urlImage: 'images/ingredientes.png',
            text: 'Ingredientes do Hambúrguer',
            imageRatioWidth: 0.30,
            textRatioWidth: 0.65,
            ratioWidth: 0.92,
            proportion: 0.15,
          ),
        /*
        * Pão e carne
        */
        if (!isIngredients)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CardIngrediente(
                urlImage: 'images/pao.png',
                text: 'Pão',
                proportion: 0.15,
              ),
              CardIngrediente(
                urlImage: 'images/carne.jpg',
                text: 'Carne',
                proportion: 0.15,
              ),
            ],
          ),
        /*
        * Frutas, verduras e legumes
        */
        if (isIngredients)
          const CardIngrediente(
            urlImage: 'images/pao.png',
            text: 'Frutas, verduras e legumes',
            subtitle: 'R\$ 1,40',
            imageRatioWidth: 0.30,
            textRatioWidth: 0.65,
            ratioWidth: 0.92,
            proportion: 0.15,
          ),
        /*
        * Queijos e cebolas
        */
        if (isIngredients)
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CardIngrediente(
                urlImage: 'images/pao.png',
                text: 'Queijos',
                proportion: 0.15,
                subtitle: 'R\$ 1,40',
              ),
              CardIngrediente(
                urlImage: 'images/carne.jpg',
                text: 'Cebolas',
                subtitle: 'R\$ 1,40',
                proportion: 0.15,
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
              CardIngrediente(
                urlImage: 'images/pao.png',
                text: 'Molhos',
                subtitle: 'R\$ 1,40',
                proportion: 0.15,
              ),
              CardIngrediente(
                urlImage: 'images/carne.jpg',
                text: 'Outros',
                subtitle: 'R\$ 1,40',
                proportion: 0.15,
              ),
            ],
          ),
      ],
    );
  }
}
