import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/models/ingrediente.dart';

class CardIngredient extends StatefulWidget {
  final Ingrediente ingredient;
  final int count;
  final int totalInsumos;
  final Function(int)? onSwitchCount;

  const CardIngredient({
    Key? key,
    required this.ingredient,
    required this.count,
    required this.totalInsumos,
    this.onSwitchCount,
  }) : super(key: key);

  @override
  State<CardIngredient> createState() => _CardIngredientState();
}

class _CardIngredientState extends State<CardIngredient> {
  int _qnt = 1;
  bool qntUpdated = false;

  @override
  Widget build(BuildContext context) {
    // Altura total da tela, subtraindo a altura da appBar
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight!;
    final deviceWidth = MediaQuery.of(context).size.width;

    if (!qntUpdated) {
      _qnt = widget.count;
      qntUpdated = true;
    }

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
                    image: widget.ingredient.urlImage,
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
                          widget.ingredient.nome,
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
                              _qnt.toString(),
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
                          '${widget.ingredient.quantidade} '
                          '${widget.ingredient.unidadeMedida}'
                          '\nR\$ ${widget.ingredient.preco.toStringAsFixed(2)}',
                          color: Colors.grey,
                          textAlign: TextAlign.left,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 50,
                          child: Botao(
                            onPressed: (_qnt == 1)
                                ? null
                                : () {
                                    setState(() => _qnt--);
                                    widget.onSwitchCount!(_qnt);
                                  },
                            icon: Icons.remove,
                            externalPadding: const EdgeInsets.only(right: 10),
                            internalPadding: EdgeInsets.zero,
                            iconSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: Botao(
                            onPressed: (widget.totalInsumos == 15 || _qnt == 3)
                                ? null
                                : () {
                                    setState(() => _qnt++);
                                    widget.onSwitchCount!(_qnt);
                                  },
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
