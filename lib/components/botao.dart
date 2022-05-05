// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Botao extends StatelessWidget {
  final String? labelText;
  final IconData? icon;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsets internalPadding;
  final EdgeInsets externalPadding;
  final bool loading;

  const Botao({
    Key? key,
    this.labelText,
    this.icon,
    this.externalPadding = EdgeInsets.zero,
    this.internalPadding = const EdgeInsets.symmetric(vertical: 12),
    this.foregroundColor = Colors.black,
    this.backgroundColor = const Color(0xfffed80b),
    this.loading = false,
    required this.onPressed,
  }) : super(key: key);

  _buildText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: (loading)
          ? [
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: foregroundColor,
                ),
              ),
            ]
          : [
              Text(
                labelText!,
                style: GoogleFonts.oxygen(
                  color: foregroundColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
    );
  }

  _buildIcon() {
    return Icon(
      icon!,
      color: foregroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: externalPadding,
      child: ElevatedButton(
        child: Padding(
          padding: internalPadding,
          child: (labelText != null) ? _buildText() : _buildIcon(),
        ),
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,

          // Arredonda as bordas do botão.
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
