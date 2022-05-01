import 'package:flutter/material.dart';
import 'package:garagem_burger/providers/provider_carrinho.dart';
import 'package:google_fonts/google_fonts.dart';
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
      children: [
        child,
        if (provider.qntItens > 0)
          Positioned(
            left: 14,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
              constraints: const BoxConstraints(
                minHeight: 14,
                minWidth: 14,
              ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: GoogleFonts.oxygen(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
