import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_text.dart';

class BotaoComSeta extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;

  const BotaoComSeta({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: CustomText(
            text,
            fontWeight: FontWeight.bold,
          ),
          leading: Icon(
            icon,
            color: Colors.black,
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.only(
            bottom: 6,
            left: 15,
            right: 6,
            top: 6,
          ),
          tileColor: Colors.grey[100],
          onTap: onTap,
        ),
      ),
    );
  }
}
