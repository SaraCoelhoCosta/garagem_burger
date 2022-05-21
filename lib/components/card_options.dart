import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_category.dart';
import 'package:garagem_burger/components/card_meat_options.dart';
import 'package:google_fonts/google_fonts.dart';

class CardOptions extends StatelessWidget {
  final Widget? child;
  final bool showCarne;

  const CardOptions({
    Key? key,
    this.showCarne = false,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*
            * Title
            */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '  ' + (showCarne ? 'Escolha a Carne' : 'Escolha o Pão'),
                  style: GoogleFonts.oxygen(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  // splashRadius: 20,
                  icon: const Icon(Icons.close_sharp),
                ),
              ],
            ),
            const Divider(
              height: 20,
              thickness: 1,
              indent: 5,
              endIndent: 5,
              color: Colors.grey,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!showCarne)
                  const CardCategory(
                    urlImage: 'images/pao.png',
                    text: 'Pão de Briochi',
                    ratioHeight: 0.12,
                  ),
                if (!showCarne)
                  const CardCategory(
                    urlImage: 'images/pao.png',
                    text: 'Pão Americano',
                    ratioHeight: 0.12,
                  ),
                if (showCarne)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            image: DecorationImage(
                              image: AssetImage('images/carne.jpg'),
                              fit: BoxFit.contain,
                            ),
                          ),
                          width: 150,
                          height: 150,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: ['Mal passada', 'No ponto', 'Bem passada']
                              .map((textOption) {
                            return CardMeatOptions(
                              text: textOption,
                              isSelected: false,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                if (showCarne)
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Quantidade',
                          style: GoogleFonts.oxygen(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        /*
                        * Botao remove
                        */
                        Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.only(
                            top: 10,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                '-',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oxygen(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*
                        * Quantidade
                        */
                        Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.only(
                            top: 10,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                '0',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oxygen(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*
                        * Botao add
                        */
                        Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.only(
                            top: 10,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                '+',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oxygen(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
