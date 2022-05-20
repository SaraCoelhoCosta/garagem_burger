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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: externalPadding,
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading)
              SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: foregroundColor,
                ),
              )
            else if (icon != null)
              Icon(
                icon!,
                color: foregroundColor,
              )
            else if (labelText != null)
              Text(
                labelText!,
                style: GoogleFonts.oxygen(
                  color: foregroundColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
          ],
        ),
        style: ElevatedButton.styleFrom(
          padding: internalPadding,
          primary: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
