import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/models/produto.dart';

class CardProduto extends StatelessWidget {
  final Produto produto;
  final Function()? onTap;

  const CardProduto({
    Key? key,
    required this.produto,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        (Scaffold.of(context).appBarMaxHeight ?? 0) -
        kBottomNavigationBarHeight;

    final ImageProvider<Object> image;
    if (produto.urlImage.isEmpty) {
      image = const AssetImage('images/hamburguer.jpg');
    } else {
      image = NetworkImage(produto.urlImage);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: LayoutBuilder(
        builder: (ctx, constraints) => SizedBox(
          height: availableHeight * 0.20,
          child: GestureDetector(
            onTap: onTap,
            child: Card(
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: FadeInImage(
                          placeholder: const AssetImage(
                              'images/placeholder-produto.jpg'),
                          image: image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: constraints.maxWidth * 0.30,
                      height: double.infinity,
                    ),
                    /*
                    * Title e Subtitle
                    */
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: constraints.maxWidth * 0.65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          /*
                          * Title
                          */
                          FittedBox(
                            child: CustomText(
                              produto.nome,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          /*
                          * Subtitle
                          */
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                child: CustomText(
                                  (produto.recipiente == null
                                          ? ''
                                          : '${produto.recipiente} de ') +
                                      '${produto.quantidade ?? 'Teste'}' +
                                      (produto.unidadeMedida ?? ' 1'),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  'R\$ ${produto.preco.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
