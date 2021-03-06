import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/card_category.dart';
import 'package:garagem_burger/components/card_ingredient.dart';
import 'package:garagem_burger/components/card_meat.dart';
import 'package:garagem_burger/components/category_grid.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/components/popup_dialog.dart';
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
  final bool isOpened;
  final bool showEditOptions;
  final void Function(BuildContext, int, Produto?) onTapConfirm;
  final void Function(Produto?)? onTapReturn;
  final void Function()? onTapEdit;
  final void Function(int)? onSwitchCount;

  const ModalProduto({
    Key? key,
    required this.produto,
    required this.onTapConfirm,
    required this.isEditing,
    required this.isOpened,
    this.showEditOptions = false,
    this.onTapEdit,
    this.onTapReturn,
    this.onSwitchCount,
  }) : super(key: key);

  @override
  State<ModalProduto> createState() => _ModalProdutoState();
}

class _ModalProdutoState extends State<ModalProduto> {
  int _qnt = 1;
  int _insumos = 1;
  String _selectedBread = '';
  String _selectedMeat = '';
  int _meatCount = 1;
  bool modalUpdated = false;
  bool hamburguerUpdated = false;
  late Hamburguer hamburguer;
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
    final pvdCarrinho = Provider.of<ProviderCarrinho>(context);
    final pvdProduto = Provider.of<ProviderProdutos>(context);

    // Altura disponível
    final totalHeight = MediaQuery.of(context).size.height;
    final appBarHeight = Scaffold.of(context).appBarMaxHeight;
    final availableHeight = (totalHeight - appBarHeight!) * 0.85;

    // Atualiza a quantidade de itens exibida no modal
    if (!modalUpdated &&
        widget.isEditing &&
        pvdCarrinho.itensCarrinho.containsKey(widget.produto.id)) {
      modalUpdated = true;
      _qnt = pvdCarrinho.itensCarrinho[widget.produto.id]!.quantidade;
    }

    // Dados do hamburguer, caso o produto seja um hamburguer
    if ((widget.produto.tipo == Produto.hamburguerCasa ||
            widget.produto.tipo == Produto.meuHamburguer) &&
        !hamburguerUpdated) {
          print('Hamburguer atualizado');
      hamburguerUpdated = true;
      hamburguer = widget.produto as Hamburguer;
      _insumos = hamburguer.totalIngredientes;
      _selectedBread = pvdProduto.hamburguerBread(hamburguer.id) ?? '';
      final _meat = pvdProduto.hamburguerMeat(hamburguer.id) ?? {};
      _selectedMeat = _meat['id'] ?? '';
      _meatCount = _meat['quantidade'] ?? 1;
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
            height: availableHeight * 0.12,
            child: Row(
              children: [
                CustomText(
                  _modalTitle(),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                const Spacer(),
                if (widget.showEditOptions)
                  Column(
                    children: [
                      const CustomText('Insumos'),
                      Chip(
                        backgroundColor: Theme.of(context).backgroundColor,
                        label: CustomText(
                          '${_insumos.toString().padLeft(2, '0')} / 15',
                        ),
                      ),
                    ],
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
              height: availableHeight * 0.55,
              child: CategoryGrid(
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
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                height: availableHeight * 0.55,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: pvdProduto.ingHamburguer(hamburguer).length,
                  itemBuilder: (ctx, index) {
                    final dadosIng =
                        pvdProduto.ingHamburguer(hamburguer)[index];
                    if (dadosIng != null) {
                      final ing = pvdProduto.ingredientById(dadosIng['id']);
                      return CardIngredient(
                        count: dadosIng['quantidade'] as int,
                        ingredient: ing!,
                        totalInsumos: _insumos,
                        onSwitchCount: (qnt) {
                          setState(() {
                            hamburguer = pvdProduto.updateHamburguer(
                              hamburguer,
                              dadosIng['id'],
                              qnt: qnt,
                            );
                            _insumos = hamburguer.totalIngredientes;
                          });
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
          /*
          * Opções de edição (Opções de Carne)
          */
          if (widget.showEditOptions && optionEdit == OptionEdit.meat)
            SizedBox(
              height: availableHeight * 0.55,
              child: CardMeat(
                insumos: _insumos,
                selectedMeat: _selectedMeat,
                meatCount: _meatCount,
                onSwitchCount: (qnt) {
                  setState(() {
                    hamburguer = pvdProduto.updateHamburguer(
                      hamburguer,
                      _selectedMeat,
                      qnt: qnt,
                    );
                    _meatCount = qnt;
                    _insumos = hamburguer.totalIngredientes;
                  });
                },
                onTap: (selectedMeat) {
                  final oldSelectedMeat = _selectedMeat;
                  setState(() {
                    _selectedMeat = selectedMeat;
                    hamburguer = pvdProduto.updateHamburguer(
                      hamburguer,
                      oldSelectedMeat,
                      newId: selectedMeat,
                    );
                  });
                },
              ),
            ),
          /*
          * Opções de edição (Opções de Pão)
          */
          if (widget.showEditOptions && optionEdit == OptionEdit.bread)
            SizedBox(
              height: availableHeight * 0.55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pvdProduto.paes.map((pao) {
                  return CardCategory(
                    urlImage: pao.urlImage,
                    text: pao.nome,
                    isSelected: pao.id == _selectedBread,
                    isNetworkImage: true,
                    imageRatioWidth: 0.30,
                    textRatioWidth: 0.65,
                    ratioWidth: 0.92,
                    onTap: () {
                      final oldSelectedBread = _selectedBread;
                      setState(() {
                        _selectedBread = pao.id;
                        hamburguer = pvdProduto.updateHamburguer(
                          hamburguer,
                          oldSelectedBread,
                          newId: _selectedBread,
                        );
                      });
                    },
                  );
                }).toList(),
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
                  onPressed: (_qnt == 1)
                      ? null
                      : () {
                          setState(() => _qnt--);
                          widget.onSwitchCount!(_qnt);
                        },
                  icon: Icons.remove,
                ),
                Botao(
                  onPressed: () {},
                  internalPadding: const EdgeInsets.symmetric(vertical: 15),
                  externalPadding: const EdgeInsets.symmetric(horizontal: 15),
                  labelText: '$_qnt',
                ),
                Botao(
                  // onPressed: () => setState(() => _qnt++),
                  onPressed: () {
                    setState(() => _qnt++);
                    widget.onSwitchCount!(_qnt);
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
          if (!widget.showEditOptions && widget.produto.isEditable)
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
          * Botão de salvar / adicionar no carrinho
          */
          Botao(
            labelText: (widget.isEditing || widget.showEditOptions)
                ? 'Salvar Alterações'
                : 'Adicionar no Carrinho',
            onPressed: (widget.produto.isEditable)
                ? () {
                    if (widget.showEditOptions) {
                      setState(() => optionEdit = OptionEdit.none);
                      widget.onTapReturn!(hamburguer);
                    } else {
                      setState(() => optionEdit = OptionEdit.none);
                      widget.onTapConfirm(
                        context,
                        _qnt,
                        hamburguer,
                      );
                    }
                  }
                : () => widget.onTapConfirm(
                      context,
                      _qnt,
                      null,
                    ),
          ),
          /*
          * Botão de voltar / cancelar
          */
          if (widget.showEditOptions)
            Botao(
              labelText: (optionEdit != OptionEdit.categories)
                  ? 'Voltar'
                  : 'Descartar Alterações',
              externalPadding: const EdgeInsets.only(top: 5),
              onPressed: () {
                if (optionEdit != OptionEdit.categories) {
                  setState(() => optionEdit = OptionEdit.categories);
                  // TODO: alterar aqui para meu hamburguer
                } else if (widget.onTapReturn != null) {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return PopupDialog(
                        titulo: 'Descartar alterações',
                        descricao:
                            'Tem certeza que deseja descartar as alterações?',
                        onPressedYesOption: () {
                          Navigator.of(context).pop(true);
                        },
                        onPressedNoOption: () {
                          Navigator.of(context).pop(false);
                        },
                      );
                    },
                  ).then((selectedYesOption) {
                    if (selectedYesOption) {
                      setState(() {
                        optionEdit = OptionEdit.none;
                        hamburguerUpdated = false;
                        hamburguer = widget.produto as Hamburguer;
                        _insumos = hamburguer.totalIngredientes;
                      });
                      widget.onTapReturn!(null);
                    }
                  });
                }
              },
            ),
        ],
      ),
    );
  }
}
