import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoAmarelo extends StatelessWidget {
  final String? labelText;
  final IconData? icon;
  final Function()? onPressed;

  const BotaoAmarelo({
    Key? key,
    this.labelText,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  _buildText() {
    return Text(
      labelText!,
      style: GoogleFonts.oxygen(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _buildIcon() {
    return Icon(
      icon!,
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: (labelText != null) ? _buildText() : _buildIcon(),
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
