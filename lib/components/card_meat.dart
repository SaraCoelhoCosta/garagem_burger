import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/card_meat_option.dart';
import 'package:garagem_burger/components/custom_text.dart';

class CardMeat extends StatefulWidget {
  const CardMeat({Key? key}) : super(key: key);

  @override
  State<CardMeat> createState() => _CardMeatState();
}

class _CardMeatState extends State<CardMeat> {
  String meatOptionSelected = 'No ponto';
  int quantidade = 1;

  final _meatOption = [
    'Mal passada',
    'No ponto',
    'Bem passada',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              children: _meatOption.map((meatOption) {
                return CardMeatOption(
                  text: meatOption,
                  isSelected: meatOption == meatOptionSelected,
                  onTap: () {
                    setState(() {
                      meatOptionSelected = meatOption;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
        Row(
          children: [
            const CustomText(
              'Quantidade:',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            const Spacer(),
            SizedBox(
              width: 50,
              child: Botao(
                onPressed: (quantidade == 1)
                    ? null
                    : () => setState(() => quantidade--),
                icon: Icons.remove,
                externalPadding: const EdgeInsets.only(right: 10),
                internalPadding: EdgeInsets.zero,
                iconSize: 20,
              ),
            ),
            SizedBox(
              width: 40,
              child: Botao(
                onPressed: () {},
                internalPadding: EdgeInsets.zero,
                labelText: quantidade.toString(),
              ),
            ),
            SizedBox(
              width: 50,
              child: Botao(
                onPressed: (quantidade == 3)
                    ? null
                    : () => setState(() => quantidade++),
                icon: Icons.add,
                externalPadding: const EdgeInsets.only(left: 10),
                internalPadding: EdgeInsets.zero,
                iconSize: 20,
              ),
            )
          ],
        ),
      ],
    );
  }
}
