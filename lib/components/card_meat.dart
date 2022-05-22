import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_meat_options.dart';
import 'package:google_fonts/google_fonts.dart';

class CardMeat extends StatelessWidget {
  const CardMeat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
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
              * Botao remover
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
              * Botao de adicionar
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
    );
  }
}
