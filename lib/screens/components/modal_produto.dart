import 'package:flutter/material.dart';
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

  _addItem() {
    setState(() => _qnt++);
  }

  _remItem() {
    setState(() => _qnt--);
  }

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
              ElevatedButton(
                child: const Icon(Icons.remove),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      (_qnt == 1) ? Colors.grey : const Color(0xfffed80b)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  overlayColor: MaterialStateProperty.all(Colors.grey),
                ),
                onPressed: (_qnt == 1) ? null : _remItem,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: ElevatedButton(
                  child: Text(
                    '$_qnt',
                    style: GoogleFonts.oxygen(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xfffed80b)),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () {},
                ),
              ),
              ElevatedButton(
                child: const Icon(Icons.add),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xfffed80b)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: _addItem,
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Botao de adicionar no carrinho
          ElevatedButton(
            child: Text(
              'Adicionar no carrinho',
              style: GoogleFonts.oxygen(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xfffed80b)),
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
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
