import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/card_category.dart';
import 'package:garagem_burger/components/card_ingredient.dart';
import 'package:garagem_burger/components/card_meat.dart';
import 'package:garagem_burger/components/category_grid.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/controllers/provider_produtos.dart';
import 'package:garagem_burger/models/hamburguer.dart';
import 'package:garagem_burger/models/produto.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:provider/provider.dart';

enum OptionEdit {
  categories,
  ingredientsGrid,
  ingredientsList,
  meat,
  bread,
  none,
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
  OptionEdit optionEdit = OptionEdit.none;

  String _modalTitle() {
    switch (optionEdit) {
      case OptionEdit.categories:
        return 'Ingredientes do Hambúrguer';
      case OptionEdit.ingredientsGrid:
        return 'Escolha os Ingredientes';
      case OptionEdit.ingredientsList:
        return 'Escolha os Ingredientes';
      case OptionEdit.meat:
        return 'Escolha a Carne';
      case OptionEdit.bread:
        return 'Escolha o Pão';
      case OptionEdit.none:
        return 'Quantidade';
    }
  }

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
    final totalHeight = MediaQuery.of(context).size.height;
    final appBarHeight = Scaffold.of(context).appBarMaxHeight;
    final availableHeight = (totalHeight - appBarHeight!) * 0.85;

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
          * Titulo do modal
          */
          SizedBox(
            height: availableHeight * 0.07,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  _modalTitle(),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          /*
          * Opções de edição (Grid de categorias ou Grid de ingredientes)
          */
          if (widget.showEditOptions &&
              (optionEdit == OptionEdit.categories ||
                  optionEdit == OptionEdit.ingredientsGrid))
            SizedBox(
              height: availableHeight * 0.60,
              child: CategoryGrid(
                isIngredients: optionEdit == OptionEdit.ingredientsGrid,
                showIngredients: () {
                  setState(() {
                    if (widget.produto.tipo == Produto.hamburguerCasa) {
                      optionEdit = OptionEdit.ingredientsGrid;
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
            ),
          /*
          * Opções de edição (Lista de ingredientes)
          */
          if (widget.showEditOptions &&
              optionEdit == OptionEdit.ingredientsList)
            Card(
              elevation: 6,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                height: availableHeight * 0.60,
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
            ),
          /*
          * Opções de edição (Opções de Carne)
          */
          if (widget.showEditOptions && optionEdit == OptionEdit.meat)
            SizedBox(
              height: availableHeight * 0.60,
              child: const CardMeat(),
            ),
          /*
          * Opções de edição (Opções de Pão)
          */
          if (widget.showEditOptions && optionEdit == OptionEdit.bread)
            SizedBox(
              height: availableHeight * 0.60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CardCategory(
                    urlImage: 'images/pao.png',
                    text: 'Pão de Briochi',
                    imageRatioWidth: 0.30,
                    textRatioWidth: 0.65,
                    ratioWidth: 0.92,
                  ),
                  CardCategory(
                    urlImage: 'images/pao.png',
                    text: 'Pão Americano',
                    imageRatioWidth: 0.30,
                    textRatioWidth: 0.65,
                    ratioWidth: 0.92,
                  ),
                ],
              ),
            ),
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
                Botao(
                  onPressed: () {},
                  internalPadding: const EdgeInsets.symmetric(vertical: 15),
                  externalPadding: const EdgeInsets.symmetric(horizontal: 15),
                  labelText: '$_qnt',
                ),
                Botao(
                  onPressed: () => setState(() => _qnt++),
                  icon: Icons.add,
                ),
              ],
            ),
          const SizedBox(height: 15),
          /*
          * Dicas
          */
          if (widget.showEditOptions)
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: CustomText(
                'Dica: Você pode adicionar até 3 unidades do mesmo ingrediente'
                ', com exceção do pão.',
                fontSize: 18,
                color: Colors.grey,
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
              onPressed: () {
                if (widget.onTapEdit != null) {
                  setState(() => optionEdit = OptionEdit.categories);
                  widget.onTapEdit!();
                }
              },
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
                  setState(() => optionEdit = OptionEdit.none);
                  widget.onTapReturn!();
                }
              },
            ),
        ],
      ),
    );
  }
}
