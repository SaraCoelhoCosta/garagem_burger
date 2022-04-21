// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final Icon prefixIcon;
  final IconButton? suffixIconButton;
  final String labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final Function(String) onFieldSubmitted;
  dynamic inputFormatters;
  final Stream<String> stream;
  final Function(String) onChanged;

  CampoTexto({
    required this.obscureText,
    required this.labelText,
    required this.stream,
    required this.onChanged,
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
    return StreamBuilder<Object>(
      stream: stream,
      builder: (context, snapshot) {
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
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            obscureText: obscureText,
          ),
        );
      },
    );
  }
}
