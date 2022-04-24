import 'package:flutter/material.dart';

class BotaoTransparente extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;

  const BotaoTransparente({
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
          title: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
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
          tileColor: const Color.fromARGB(255, 244, 244, 245),
          onTap: onTap,
        ),
      ),
    );
  }
}
