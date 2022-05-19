import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_ingrediente.dart';
import 'package:garagem_burger/components/card_nome.dart';
import 'package:google_fonts/google_fonts.dart';

class CardOpcoes extends StatelessWidget {
  final String urlImage;
  final String text;
  final bool quantity;
  final double imageRatioWidth;
  final double textRatioWidth;
  final double ratioWidth;

  const CardOpcoes({
    Key? key,
    required this.urlImage,
    required this.text,
    this.imageRatioWidth = 0.50,
    this.textRatioWidth = 0.45,
    this.ratioWidth = 0.45,
    this.quantity = false,
  }) : super(key: key);

  // double dividerSize() {
  //   if (urlImage == 'images/pao.png') {
  //     return 280;
  //   } else if (urlImage == 'images/carne.jpg') {
  //     return 420;
  //   }
  //   return 0;
  // }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Card(
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
              Text(
                text,
                style: GoogleFonts.oxygen(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(
                height: 20,
                thickness: 1,
                indent: 5,
                endIndent: 5,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (urlImage == 'images/pao.png')
                      CardIngrediente(
                        urlImage: urlImage,
                        text: 'Pão de Briochi',
                        proportion: 0.12,
                      ),
                    if (urlImage == 'images/pao.png')
                      CardIngrediente(
                        urlImage: urlImage,
                        text: 'Pão Americano',
                        proportion: 0.12,
                      ),
                    if (urlImage == 'images/carne.jpg')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
                              children: [
                                GestureDetector(
                                  onTap: null,
                                  child: const CardNome(text: 'Mal passada'),
                                ),
                                GestureDetector(
                                  onTap: null,
                                  child: const CardNome(text: 'No ponto'),
                                ),
                                GestureDetector(
                                  onTap: null,
                                  child: const CardNome(text: 'Bem passada'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    if (quantity)
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
