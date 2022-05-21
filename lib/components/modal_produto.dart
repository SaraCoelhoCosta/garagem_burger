import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/models/produto.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ModalProduto extends StatefulWidget {
  final Produto produto;
  final bool isEditing;
  final bool showEditOptions;
  final Widget? editOptions;
  final void Function(BuildContext, int) onTap;
  final void Function()? onTapEdit;
  final void Function()? onTapCancel;

  const ModalProduto({
    Key? key,
    required this.produto,
    required this.onTap,
    required this.isEditing,
    this.showEditOptions = false,
    this.editOptions,
    this.onTapEdit,
    this.onTapCancel,
  }) : super(key: key);

  @override
  State<ModalProduto> createState() => _ModalProdutoState();
}

class _ModalProdutoState extends State<ModalProduto> {
  int _qnt = 1;
  bool modalUpdated = false;

  @override
  Widget build(BuildContext context) {
    final pvdCarrinho = Provider.of<ProviderCarrinho>(
      context,
      listen: false,
    );
    if (!modalUpdated &&
        widget.isEditing &&
        pvdCarrinho.itensCarrinho.containsKey(widget.produto.id)) {
      modalUpdated = true;
      _qnt = pvdCarrinho.itensCarrinho[widget.produto.id]!.quantidade;
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*
          * Opções de edição
          */
          if (widget.showEditOptions) widget.editOptions!,
          /*
          * Titulo do modal
          */
          if (!widget.showEditOptions)
            Row(
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
          /*
          * Botoes de aumentar e diminuir quantidade
          */
          if (!widget.showEditOptions)
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
          /*
          * Dicas
          */
          if (widget.showEditOptions)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Dica: Você pode adicionar até 3 unidades do mesmo ingrediente'
                ', com exceção do pão.',
                style: GoogleFonts.oxygen(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          /*
          * Botão de editar produto
          */
          if (widget.isEditing && !widget.showEditOptions)
            Botao(
              labelText: 'Editar Produto',
              externalPadding: const EdgeInsets.only(bottom: 5),
              onPressed: widget.onTapEdit,
            ),
          /*
          * Botão de salvar 
          */
          Botao(
            labelText: (widget.isEditing)
                ? 'Salvar Alterações'
                : 'Adicionar no Carrinho',
            onPressed: () => widget.onTap(
              context,
              _qnt,
            ),
          ),
          /*
          * Botão de cancelar
          */
          if (widget.isEditing && widget.showEditOptions)
            Botao(
              labelText: 'Cancelar',
              externalPadding: const EdgeInsets.only(top: 5),
              onPressed: widget.onTapCancel,
            ),
        ],
      ),
    );
  }
}
