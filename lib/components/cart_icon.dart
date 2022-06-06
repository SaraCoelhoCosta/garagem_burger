import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_text.dart';

class CartIcon extends StatelessWidget {
  final int value;
  final Color? color;

  const CartIcon({
    Key? key,
    required this.value,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        const Icon(Icons.shopping_cart_outlined),
        if (value > 0)
          Positioned(
            left: 14,
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minHeight: 14,
                minWidth: 14,
              ),
              child: CustomText(
                value.toString(),
                fontSize: 10,
                fontWeight: FontWeight.w900,
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
