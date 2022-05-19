import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:google_fonts/google_fonts.dart';

class CardItem extends StatelessWidget {
  final Function()? addItem;
  final Function()? removeItem;

  const CardItem({
    Key? key,
    required this.addItem,
    required this.removeItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Altura total da tela, subtraindo as alturas da appBar e bottomBar
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight! -
        kBottomNavigationBarHeight;

    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
      ),
      child: SizedBox(
        height: availableHeight * 0.20,
        /*
        * Layout Builder
        */
        child: LayoutBuilder(
          builder: (ctx, constraints) => Card(
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
                  width: constraints.maxWidth * 0.30,
                ),
                /*
                * Tudo
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
                            height: constraints.maxWidth * 0.07,
                            width: constraints.maxWidth * 0.07,
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
                      * Subtitle
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
      ),
    );
  }
}
