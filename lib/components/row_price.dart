import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_text.dart';

class RowPrice extends StatelessWidget {
  final double value;
  final String text;

  const RowPrice({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text,
            fontSize: 20,
          ),
          CustomText(
            'R\$ ${value.toStringAsFixed(2)}',
            fontSize: 20,
          ),
        ],
      ),
    );
  }
}
