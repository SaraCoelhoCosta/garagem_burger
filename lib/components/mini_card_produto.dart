import 'package:flutter/material.dart';

class MiniCardProduto extends StatelessWidget {
  const MiniCardProduto({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        child: Image.asset(
          'images/hamburguer.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}