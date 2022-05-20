import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/models/produto.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ModalProduto extends StatefulWidget {
  final Produto produto;
  final bool isEditing;
  final void Function(BuildContext, int) onTap;
  final void Function(BuildContext, int)? onTapEdit;
  // TODO: juao -> Mexe nesse onTapEdit

  const ModalProduto({
    Key? key,
    required this.produto,
    required this.onTap,
    required this.isEditing,
    this.onTapEdit,
  }) : super(key: key);

  @override
  State<ModalProduto> createState() => _ModalProdutoState();
}

class _ModalProdutoState extends State<ModalProduto> {
  int _qnt = 1;
  bool modalUpdated = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCarrinho>(context, listen: false);

    if (!modalUpdated &&
        widget.isEditing &&
        provider.itensCarrinho.containsKey(widget.produto.id)) {
      modalUpdated = true;
      _qnt = provider.itensCarrinho[widget.produto.id]!.quantidade;
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
              Botao(
                onPressed: (_qnt > 1) ? () => setState(() => _qnt--) : null,
                icon: Icons.remove,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Botao(
                  onPressed: () {},
                  internalPadding: const EdgeInsets.symmetric(vertical: 15),
                  labelText: '$_qnt',
                ),
              ),
              Botao(
                onPressed: () {
                  setState(() => _qnt++);
                },
                icon: Icons.add,
              ),
            ],
          ),

          const SizedBox(height: 15),

          if (widget.isEditing)
            Botao(
              labelText: 'Editar Produto',
              externalPadding: const EdgeInsets.only(bottom: 5),
              onPressed: () => widget.onTapEdit,
            ),

          Botao(
            labelText: (widget.isEditing)
                ? 'Salvar Alterações'
                : 'Adicionar no Carrinho',
            onPressed: () => widget.onTap(
              context,
              _qnt,
            ),
          ),
        ],
      ),
    );
  }
}
