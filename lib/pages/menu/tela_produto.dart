import 'package:flutter/material.dart';
import 'package:garagem_burger/components/app_bar_button.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/components/popup_dialog.dart';
import 'package:garagem_burger/controllers/provider_produtos.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/models/hamburguer.dart';
import 'package:garagem_burger/models/ingrediente.dart';
import 'package:garagem_burger/models/produto.dart';
import 'package:garagem_burger/components/modal_produto.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:garagem_burger/pages/carrinho/tela_carrinho.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:bordered_text/bordered_text.dart';

class TelaProduto extends StatefulWidget {
  const TelaProduto({Key? key}) : super(key: key);

  @override
  State<TelaProduto> createState() => _TelaProdutoState();
}

class _TelaProdutoState extends State<TelaProduto>
    with SingleTickerProviderStateMixin {
  bool showEditOptions = false;
  bool openedModal = false;
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  final _duration = const Duration(milliseconds: 350);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: _duration,
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  void showModal(bool show) {
    setState(() {
      if (show) {
        openedModal = true;
        _controller?.forward();
      } else {
        openedModal = false;
        _controller?.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pvdProduto = Provider.of<ProviderProdutos>(context);
    final user = Provider.of<ProviderUsuario>(context).usuario;
    final provider = Provider.of<ProviderCarrinho>(context);
    List arguments = ModalRoute.of(context)?.settings.arguments as List;
    Produto produto = arguments[1] as Produto;
    bool isEditing = arguments[0] as bool;

    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      title: FittedBox(
        child: CustomText(
          produto.nome,
          bordered: true,
          fontSize: 30,
          fontType: FontType.title,
          color: Colors.white,
        ),
      ),
    );

    final totalHeight = MediaQuery.of(context).size.height;
    final appBarHeight =
        appBar.preferredSize.height + MediaQuery.of(context).padding.top;
    final availableHeight = totalHeight - appBarHeight;
    final maxHeight = showEditOptions ? 0.95 : ((isEditing) ? 0.47 : 0.40);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      floatingActionButton: (provider.emptyList || showEditOptions)
          ? null
          : FloatingActionButton(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: Stack(
        alignment: Alignment.bottomCenter,
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
            /*
            * Detalhes do produto
            */
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: appBarHeight + 20),
                  /*
                  * Preço inicial
                  */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        'Preço',
                        bordered: true,
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        'R\$ ${produto.preco.toStringAsFixed(2)}',
                        bordered: true,
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  /*
                  * Detalhes do produto
                  */
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CustomText(
                        'Itens',
                        bordered: true,
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      CustomText(
                        'Quantidade',
                        bordered: true,
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Column(
                    children:
                        (produto as Hamburguer).ingredientes.map((ingrediente) {
                      final ing = pvdProduto.ingredientById(ingrediente['id']);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            flex: 7,
                            child: CustomText(
                              '${ingrediente['quantidade']}x ${ing.nome}',
                              bordered: true,
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: CustomText(
                              '${ing.quantidade * (ingrediente['quantidade'] as int)} '
                              '${ing.unidadeMedida}'
                              '${(ing.unidadeMedida == Ingrediente.fatia && ingrediente['quantidade'] > 1 ? 's' : '')}',
                              bordered: true,
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  /*
                  * Preço adicional
                  */
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        'Adicionais',
                        bordered: true,
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        'R\$ ${produto.preco.toStringAsFixed(2)}',
                        bordered: true,
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  /*
                  * Preço total
                  */
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        'Total',
                        bordered: true,
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        'R\$ ${produto.preco.toStringAsFixed(2)}',
                        bordered: true,
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          /*
          * Animações do modal
          */
          AnimatedContainer(
            duration: _duration,
            height: availableHeight * (openedModal ? maxHeight : 0.07),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: availableHeight * 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => showModal(!openedModal),
                        icon: Icon(
                          (openedModal)
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_up_outlined,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: _duration,
                  constraints: BoxConstraints(
                    minHeight: availableHeight * (openedModal ? 0.07 : 0),
                    maxHeight:
                        availableHeight * (openedModal ? maxHeight - 0.1 : 0),
                  ),
                  child: FadeTransition(
                    opacity: _opacityAnimation!,
                    child: SingleChildScrollView(
                      /*
                      * Modal
                      */
                      child: ModalProduto(
                        produto: produto,
                        isEditing: isEditing,
                        showEditOptions: showEditOptions,
                        onTapEdit: () {
                          setState(() => showEditOptions = true);
                        },
                        onTapReturn: () {
                          setState(() => showEditOptions = false);
                        },
                        onTap: (ctx, qnt) {
                          if (user == null) {
                            showDialog(
                              context: ctx,
                              builder: (ctx) {
                                return PopupDialog(
                                  titulo: 'Faça o Login',
                                  descricao:
                                      'Não foi possível adicionar o item ao carrinho, '
                                      'faça login para continuar',
                                  yesLabel: 'Efetuar login',
                                  noLabel: 'Cancelar',
                                  onPressedNoOption: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  onPressedYesOption: () {
                                    Navigator.of(ctx).pushNamedAndRemoveUntil(
                                      Rotas.home,
                                      (_) => false,
                                    );
                                  },
                                );
                              },
                            );
                          }

                          if (user != null) {
                            showModal(false);
                            (isEditing)
                                ? provider.editarItemCarrinho(produto, qnt)
                                : provider.addItemCarrinho(produto, qnt);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: CustomText(
                                  (isEditing)
                                      ? '${produto.nome} atualizado para $qnt'
                                      : '$qnt ${produto.nome} adicionado no carrinho',
                                  textAlign: TextAlign.center,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                elevation: 6.0,
                                backgroundColor: Colors.blue,
                                duration: const Duration(milliseconds: 1500),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
