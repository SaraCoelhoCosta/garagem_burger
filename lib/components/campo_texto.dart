// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  final bool obscureText;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  dynamic inputFormatters;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  bool? enabled;

  CampoTexto({
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.textInputAction,
    this.onFieldSubmitted,
    this.keyboardType,
    this.focusNode,
    this.inputFormatters,
    this.suffixIcon,
    this.hintText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          hintText: hintText,
        ),
        
        controller: controller,
        keyboardType: keyboardType,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        enabled: enabled,
      ),
    );
  }
}
