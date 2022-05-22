import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:provider/provider.dart';

class IconeCarrinho extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;

  const IconeCarrinho({
    Key? key,
    required this.child,
    required this.value,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCarrinho>(context);
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        child,
        if (provider.qntItens > 0)
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
                value,
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
