import 'package:flutter/material.dart';
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
    // Altura total da tela, subtraindo as alturas da appBar e bottomBar
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
                          placeholder: const AssetImage('images/placeholder.jpg'),
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
                            child: Text(
                              produto.nome, // max: 27 caracteres
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          /*
                            * Subtitle
                            */
                          Text(
                            'R\$ ${produto.preco.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
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

      // child: LayoutBuilder(
      //   builder: (ctx, constraints) => SizedBox(
      //     height: availableHeight * 0.20,
      //     width: MediaQuery.of(context).size.width -
      //         16, // Subtrai do padding acima
      //     child: GestureDetector(
      //       onTap: onTap,
      //       child: Card(
      //         elevation: 6.0,
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(15.0),
      //         ),
      //         child: Padding(
      //           padding: const EdgeInsets.all(5),
      //           child: Row(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               /*
      //               * Leading (Imagem)
      //               */
      //               Container(
      //                 decoration: const BoxDecoration(
      //                   borderRadius: BorderRadius.all(
      //                     Radius.circular(15),
      //                   ),
      //                   image: DecorationImage(
      //                     image: AssetImage('images/hamburguer.jpg'),
      //                     fit: BoxFit.cover,
      //                   ),
      //                 ),
      //                 width: constraints.maxWidth * 0.30,
      //               ),
      //               /*
      //               * Title e Subtitle
      //               */
      //               SizedBox(width: constraints.maxWidth * 0.05),
      //               Container(
      //                 padding: const EdgeInsets.symmetric(vertical: 12),
      //                 width: constraints.maxWidth * 0.60,
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                   children: [
      //                     /*
      //                     * Title
      //                     */
      //                     FittedBox(
      //                       child: Text(
      //                         produto.nome, // max: 27 caracteres
      //                         style: const TextStyle(
      //                           fontSize: 20,
      //                           fontWeight: FontWeight.bold,
      //                           color: Colors.black,
      //                         ),
      //                       ),
      //                     ),
      //                     /*
      //                     * Subtitle
      //                     */
      //                     Text(
      //                       'R\$ ${produto.preco.toStringAsFixed(2)}',
      //                       style: const TextStyle(
      //                         fontSize: 18,
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.grey,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(width: constraints.maxWidth * 0.05),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
