import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoAmarelo extends StatelessWidget {
  final String labelText;
  final Function() onPressed;

  const BotaoAmarelo({
    Key? key, 
    required this.labelText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Text(
          labelText,
          style: GoogleFonts.oxygen(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: const Color(0xfffed80b),

        // Arredonda as bordas do botão.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
