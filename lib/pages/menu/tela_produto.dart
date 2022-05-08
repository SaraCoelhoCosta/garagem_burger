import 'package:flutter/material.dart';
import 'package:garagem_burger/components/app_bar_button.dart';
import 'package:garagem_burger/components/card_ingrediente.dart';
import 'package:garagem_burger/models/produto.dart';
import 'package:garagem_burger/components/modal_produto.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:garagem_burger/pages/carrinho/tela_carrinho.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TelaProduto extends StatelessWidget {
  const TelaProduto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCarrinho>(context);
    List arguments = ModalRoute.of(context)?.settings.arguments as List;
    Produto produto = arguments[1] as Produto;
    bool isEditing = arguments[0] as bool;

    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      title: Text(
        produto.nome,
        style: GoogleFonts.keaniaOne(
          fontSize: 30,
        ),
      ),
    );

    final appBarHeight =
        appBar.preferredSize.height + MediaQuery.of(context).padding.top;
    final availableHeigth = MediaQuery.of(context).size.height - appBarHeight;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      floatingActionButton: (provider.emptyList)
          ? null
          : FloatingActionButton(
              mini: true,
              backgroundColor: const Color(0xfffed80b),
              foregroundColor: Colors.black,
              child: const Icon(
                Icons.shopping_cart_outlined,
              ),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                Rotas.main,
                (_) => false,
                arguments: {
                  'index': 2,
                  'page': const TelaCarrinho(),
                  'button': const AppBarButton(
                    icon: Icons.delete,
                    tipoFuncao: TipoFuncao.limparCarrinho,
                  ),
                },
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Stack(
        children: [
          Container(
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
            child: Column(
              children: [
                SizedBox(height: appBarHeight),
                /*
                * Preço
                */
                Text(
                  'R\$ ${produto.preco.toStringAsFixed(2)}',
                  style: GoogleFonts.oxygen(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                /*
                * Detalhes do hamburguer e insumos
                */
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    /*
                    * Detalhes do hamburguer
                    */
                    Text(
                      'ComboBox',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20),
                    /*
                    * Insumos
                    */
                    Text(
                      'Insumos', // max: 27 caracteres
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                /*
                * Botões de editar
                */
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CardIngrediente(
                          urlImage: 'images/pao.png',
                          text: 'Pão',
                        ),
                        CardIngrediente(
                          urlImage: 'images/carne.jpg',
                          text: 'Carne',
                        ),
                      ],
                    ),
                    const CardIngrediente(
                      urlImage: 'images/ingredientes.png',
                      text: 'Ingredientes do Hambúrguer',
                      imageRatioWidth: 0.30,
                      textRatioWidth: 0.65,
                      ratioWidth: 0.90,
                    ),
                  ],
                ),
              ],
            ),
          ),
          /*
          * Modal
          */
          DraggableScrollableSheet(
            minChildSize: 0.07,
            initialChildSize: 0.07,
            maxChildSize: 0.40,
            builder: (ctx, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      SizedBox(
                        height: availableHeigth * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.keyboard_arrow_up_outlined,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ModalProduto(
                        produto: produto,
                        onTap: (ctx, qnt) {
                          (isEditing)
                              ? provider.editarItemCarrinho(produto, qnt)
                              : provider.addItemCarrinho(produto, qnt);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                (isEditing)
                                    ? '${produto.nome} atualizado para $qnt'
                                    : '$qnt ${produto.nome} adicionado no carrinho',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oxygen(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              elevation: 6.0,
                              backgroundColor: Colors.blue,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        isEditing: isEditing,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
