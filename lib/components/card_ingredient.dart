import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:google_fonts/google_fonts.dart';

class CardIngredient extends StatelessWidget {
  final Function()? addItem;
  final Function()? removeItem;

  const CardIngredient({
    Key? key,
    this.addItem,
    this.removeItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Altura total da tela, subtraindo a altura da appBar
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight!;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
      ),
      child: SizedBox(
        height: availableHeight * 0.20,
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
                  image: DecorationImage(
                    image: AssetImage('images/pao.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                width: deviceWidth * 0.25,
              ),
              /*
              * Tudo
              */
              Container(
                padding: const EdgeInsets.all(12),
                width: deviceWidth * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /*
                    * Title
                    */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Geleia de pimenta',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: deviceWidth * 0.07,
                          width: deviceWidth * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                '1',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oxygen(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    /*
                    * Subtitle (Quantidade e preço)
                    */
                    Row(
                      children: [
                        const Text(
                          'Porção de 180g\n'
                          'R\$ 0,70',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Botao(
                          onPressed: removeItem,
                          icon: Icons.remove,
                          externalPadding: const EdgeInsets.only(right: 10),
                        ),
                        Botao(
                          onPressed: addItem,
                          icon: Icons.add,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
