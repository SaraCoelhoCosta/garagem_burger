import 'package:flutter/material.dart';
import 'package:garagem_burger/models/produto.dart';
import 'package:garagem_burger/components/modal_produto.dart';
import 'package:garagem_burger/providers/provider_carrinho.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TelaProduto extends StatelessWidget {
  const TelaProduto({Key? key}) : super(key: key);

  // void _addCarrinho(BuildContext context, int qnt) {
  //   Navigator.of(context).pop(); // Fecha o modal

  //   // Provider.of<ProviderCarrinho>(
  //   //   context,
  //   //   listen: false,
  //   // ).addItemCarrinho(produto, qnt);

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(
  //         '$qnt produto(s) adicionado(s) no carrinho',
  //         textAlign: TextAlign.center,
  //         style: GoogleFonts.oxygen(
  //           fontSize: 16.0,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       elevation: 6.0,
  //       backgroundColor: Colors.blue,
  //       duration: const Duration(seconds: 2),
  //     ),
  //   );
  // }

  _openModal(BuildContext context, Produto produto) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ModalProduto(
          // addCarrinho: _addCarrinho,
          addCarrinho: (context, qnt) {
            Navigator.of(context).pop(); // Fecha o modal

            Provider.of<ProviderCarrinho>(
              context,
              listen: false,
            ).addItemCarrinho(produto, qnt);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '$qnt produto(s) adicionado(s) no carrinho',
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
    Produto produto = ModalRoute.of(context)?.settings.arguments as Produto;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('images/fundo-hamburguer.jpeg'),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Botao voltar
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Nome do produto e preco
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  produto.nome,
                  style: GoogleFonts.oxygen(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'R\$ ${produto.preco.toStringAsFixed(2)}',
                  style: GoogleFonts.oxygen(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xfffed80b),
        foregroundColor: Colors.black,
        child: const Icon(
          Icons.keyboard_arrow_up_outlined,
          size: 35,
        ),
        onPressed: () => _openModal(context, produto),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
