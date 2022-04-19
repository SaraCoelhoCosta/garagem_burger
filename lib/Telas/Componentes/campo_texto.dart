import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final Icon prefixIcon;
  final IconButton? suffixIconButton;
  final String labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  dynamic Function(String?)? onSaved;
  final Function(String) onFieldSubmitted;
  dynamic inputFormatters;
  dynamic validator;

  CampoTexto({
    required this.onSaved,
    required this.obscureText,
    required this.labelText,
    required this.validator,
    required this.prefixIcon,
    required this.textInputAction,
    required this.onFieldSubmitted,
    this.keyboardType,
    this.focusNode,
    this.suffixIconButton,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIconButton,
          labelText: labelText,
        ),
        keyboardType: keyboardType,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
        onSaved: onSaved,
        validator: validator,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
      ),
    );
  }
}
