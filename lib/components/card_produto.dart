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
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
      ),
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
                    image: DecorationImage(
                      image: AssetImage('images/hamburguer.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: MediaQuery.of(context).size.height * 0.15,
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                /*
                * Title e Subtitle
                */
                Container(
                  padding: const EdgeInsets.all(12),
                  height: MediaQuery.of(context).size.height * 0.15,
                  // Definir essa propriedade de uma forma melhor...
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      /*
                      * Title
                      */
                      Text(
                        produto.nome, // max: 27 caracteres
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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
    );
  }
}
