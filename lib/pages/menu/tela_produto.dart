import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_ingrediente.dart';
import 'package:garagem_burger/models/produto.dart';
import 'package:garagem_burger/components/modal_produto.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TelaProduto extends StatelessWidget {
  const TelaProduto({Key? key}) : super(key: key);

  _openModal(BuildContext context, Produto produto) {
    List arguments = ModalRoute.of(context)?.settings.arguments as List;
    bool isEditing = arguments[0] as bool;
    Produto produto = arguments[1] as Produto;

    final provider = Provider.of<ProviderCarrinho>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ModalProduto(
          produto: produto,
          isEditing: isEditing,
          onTap: (context, qnt) {
            Navigator.of(context).pop();

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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List arguments = ModalRoute.of(context)?.settings.arguments as List;
    Produto produto = arguments[1] as Produto;

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

    final appBarHeight = appBar.preferredSize.height + MediaQuery.of(context).padding.top;

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
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CardIngrediente(
                      urlImage: 'images/pao.png',
                      text: 'Pão',
                    ),
                    // SizedBox(width: 5),
                    CardIngrediente(
                      urlImage: 'images/carne.jpg',
                      text: 'Carne',
                    ),
                  ],
                ),
                const CardIngrediente(
                    urlImage: 'images/ingredientes.png',
                    text: 'Ingredientes do Hambúrguer'),
              ],
            ),
            // DropdownButton<Produto>(
            //           value: currentProduto,
            //           items: pvdProduto.listaProduto.map((produto) {
            //             return DropdownMenuItem<Produto>(
            //               value: produto,
            //               child: Text(
            //                 produto.nome!,
            //               ),
            //             );
            //           }).toList(),
            //           onChanged: (Produto? selectedProduto) {
            //             setState(() {
            //               currentProduto = selectedProduto!;
            //             });
            //           },
            //         ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xfffed80b),
        foregroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () => _openModal(context, produto),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
