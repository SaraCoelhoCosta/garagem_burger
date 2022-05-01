import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao_amarelo.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalProduto extends StatefulWidget {
  final void Function(BuildContext, int) addCarrinho;

  const ModalProduto({
    Key? key,
    required this.addCarrinho,
  }) : super(key: key);

  @override
  State<ModalProduto> createState() => _ModalProdutoState();
}

class _ModalProdutoState extends State<ModalProduto> {
  int _qnt = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Titulo do modal
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Quantidade',
                style: GoogleFonts.oxygen(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Botoes de aumentar e diminuir quantidade
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BotaoAmarelo(
                onPressed: (_qnt == 1)
                    ? null
                    : () {
                        setState(() => _qnt--);
                      },
                icon: Icons.remove,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: BotaoAmarelo(
                  onPressed: () {},
                  labelText: '$_qnt',
                ),
              ),
              BotaoAmarelo(
                onPressed: () {
                  setState(() => _qnt++);
                },
                icon: Icons.add,
              ),
            ],
          ),

          const SizedBox(height: 15),

          BotaoAmarelo(
            labelText: 'Adicionar no carrinho',
            onPressed: () => widget.addCarrinho(
              context,
              _qnt,
            ),
          ),
        ],
      ),
    );
  }
}
