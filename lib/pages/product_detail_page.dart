import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_text.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      title: const FittedBox(
        child: CustomText(
          'Nome do Produto',
          bordered: true,
          fontSize: 30,
          fontType: FontType.title,
          color: Colors.white,
        ),
      ),
    );

    // Altura disponivel
    // final totalHeight = MediaQuery.of(context).size.height;
    // final appBarHeight =
    //     appBar.preferredSize.height + MediaQuery.of(context).padding.top;
    // final availableHeight = totalHeight - appBarHeight;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Container(
        width: double.infinity,
        /*
        * Imagem de background da tela
        */
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('images/fundo-hamburguer.jpeg'),
          ),
        ),
      ),
    );
  }
}
