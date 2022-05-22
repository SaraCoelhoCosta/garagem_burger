import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/card_category.dart';
import 'package:garagem_burger/components/card_ingredient.dart';
import 'package:garagem_burger/components/card_meat.dart';
import 'package:garagem_burger/components/category_grid.dart';
import 'package:garagem_burger/controllers/provider_produtos.dart';
import 'package:garagem_burger/models/hamburguer.dart';
import 'package:garagem_burger/models/produto.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

enum OptionEdit {
  categories,
  ingredientsGrid,
  ingredientsList,
  meat,
  bread,
}

class ModalProduto extends StatefulWidget {
  final Produto produto;
  final bool isEditing;
  final bool showEditOptions;
  final void Function(BuildContext, int) onTap;
  final void Function()? onTapEdit;
  final void Function()? onTapReturn;

  const ModalProduto({
    Key? key,
    required this.produto,
    required this.onTap,
    required this.isEditing,
    this.showEditOptions = false,
    this.onTapEdit,
    this.onTapReturn,
  }) : super(key: key);

  @override
  State<ModalProduto> createState() => _ModalProdutoState();
}

class _ModalProdutoState extends State<ModalProduto> {
  int _qnt = 1;
  bool modalUpdated = false;
  OptionEdit optionEdit = OptionEdit.categories;

  @override
  Widget build(BuildContext context) {
    final pvdCarrinho = Provider.of<ProviderCarrinho>(
      context,
      listen: false,
    );
    final pvdProduto = Provider.of<ProviderProdutos>(
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
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*
          * Opções de edição
          */
          if (widget.showEditOptions &&
              (optionEdit == OptionEdit.categories ||
                  optionEdit == OptionEdit.ingredientsGrid))
            CategoryGrid(
              isIngredients: optionEdit == OptionEdit.ingredientsGrid,
              showIngredients: () {
                setState(() {
                  if (widget.produto.tipo == Produto.hamburguerCasa) {
                    optionEdit = OptionEdit.ingredientsList;
                  } else {
                    optionEdit = OptionEdit.ingredientsGrid;
                  }
                });
              },
              showMeat: () {
                setState(() => optionEdit = OptionEdit.meat);
              },
              showBread: () {
                setState(() => optionEdit = OptionEdit.bread);
              },
            ),
          if (widget.showEditOptions &&
              optionEdit == OptionEdit.ingredientsList)
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: (widget.produto as Hamburguer).ingredientes.length,
                itemBuilder: (ctx, index) {
                  final ing =
                      (widget.produto as Hamburguer).ingredientes[index];
                  return CardIngredient(
                    count: ing['quantidade'] as int,
                    ingredient: pvdProduto.ingredientById(ing['id']),
                  );
                },
              ),
            ),
          if (widget.showEditOptions && optionEdit == OptionEdit.meat)
            const CardMeat(),
          if (widget.showEditOptions && optionEdit == OptionEdit.bread)
            const CardCategory(
              urlImage: 'images/pao.png',
              text: 'Pão de Briochi',
              imageRatioWidth: 0.30,
              textRatioWidth: 0.65,
              ratioWidth: 0.92,
            ),
          if (widget.showEditOptions && optionEdit == OptionEdit.bread)
            const CardCategory(
              urlImage: 'images/pao.png',
              text: 'Pão Americano',
              imageRatioWidth: 0.30,
              textRatioWidth: 0.65,
              ratioWidth: 0.92,
            ),
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
          * Botão de voltar
          */
          if (widget.isEditing && widget.showEditOptions)
            Botao(
              labelText: 'Voltar',
              externalPadding: const EdgeInsets.only(top: 5),
              onPressed: () {
                if (optionEdit != OptionEdit.categories) {
                  setState(() => optionEdit = OptionEdit.categories);
                } else if (widget.onTapReturn != null) {
                  widget.onTapReturn!();
                }
              },
            ),
        ],
      ),
    );
  }
}
