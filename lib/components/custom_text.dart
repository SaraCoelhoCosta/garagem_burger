import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum FontType { title, normal }

class CustomText extends StatelessWidget {
  final String label;
  final bool bordered;
  final Color? color;
  final Color borderColor;
  final double fontSize;
  final FontWeight fontWeight;
  final FontType fontType;
  final TextAlign textAlign;

  const CustomText(
    this.label, {
    Key? key,
    this.bordered = false,
    this.fontType = FontType.normal,
    this.color = Colors.black,
    this.borderColor = Colors.black,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bordered) {
      return BorderedText(
        strokeColor: borderColor,
        strokeWidth: 3,
        child: Text(
          label,
          textAlign: textAlign,
          style: (fontType == FontType.title)
              ? GoogleFonts.keaniaOne(
                  color: color,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                )
              : GoogleFonts.oxygen(
                  color: color,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
        ),
      );
    } else {
      return Text(
        label,
        textAlign: textAlign,
        style: (fontType == FontType.title)
            ? GoogleFonts.keaniaOne(
                color: color,
                fontSize: fontSize,
                fontWeight: fontWeight,
              )
            : GoogleFonts.oxygen(
                color: color,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
      );
    }
  }
}
