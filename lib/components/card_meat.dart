import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/card_meat_option.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/controllers/provider_produtos.dart';
import 'package:garagem_burger/models/ingrediente.dart';
import 'package:provider/provider.dart';

class CardMeat extends StatefulWidget {
  final Function(String)? onTap;
  final Function(int)? onSwitchCount;
  final String selectedMeat;
  final int meatCount;
  final int insumos;

  const CardMeat({
    Key? key,
    this.onTap,
    this.onSwitchCount,
    required this.meatCount,
    required this.selectedMeat,
    required this.insumos,
  }) : super(key: key);

  @override
  State<CardMeat> createState() => _CardMeatState();
}

class _CardMeatState extends State<CardMeat> {
  String meatOptionSelected = '';
  int quantidade = 1;
  bool updatedMeat = false;
  late List<Ingrediente> meatOptions;

  @override
  Widget build(BuildContext context) {
    final pvdProduto = Provider.of<ProviderProdutos>(context);

    if (!updatedMeat) {
      updatedMeat = true;
      quantidade = widget.meatCount;
      meatOptions = pvdProduto.carnes;
      meatOptionSelected = widget.selectedMeat;
    }

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
              children: meatOptions.map((meatOption) {
                return CardMeatOption(
                  value: meatOption.id,
                  text: meatOption.nome,
                  isSelected: meatOption.id == meatOptionSelected,
                  onTap: () {
                    setState(() => meatOptionSelected = meatOption.id);
                    widget.onTap!(meatOptionSelected);
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
                    : () {
                        setState(() => quantidade--);
                        widget.onSwitchCount!(quantidade);
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
                onPressed: () {},
                internalPadding: EdgeInsets.zero,
                labelText: quantidade.toString(),
              ),
            ),
            SizedBox(
              width: 50,
              child: Botao(
                onPressed: (quantidade == 3 || widget.insumos == 15)
                    ? null
                    : () {
                        setState(() => quantidade++);
                        widget.onSwitchCount!(quantidade);
                      },
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
