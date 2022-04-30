// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  dynamic inputFormatters;
  final Stream<String>? stream;
  final Function(String)? onChanged;

  CampoTexto({
    required this.obscureText,
    required this.labelText,
    this.stream,
    this.onChanged,
    this.prefixIcon,
    this.textInputAction,
    this.onFieldSubmitted,
    this.keyboardType,
    this.focusNode,
    this.inputFormatters,
    this.suffixIcon,
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
              suffixIcon: suffixIcon,
              labelText: labelText,
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
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
