import 'package:flutter/material.dart';
import 'package:garagem_burger/components/app_bar_button.dart';
import 'package:garagem_burger/components/card_ingrediente.dart';
import 'package:garagem_burger/components/popup_dialog.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/models/produto.dart';
import 'package:garagem_burger/components/modal_produto.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:garagem_burger/pages/carrinho/tela_carrinho.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TelaProduto extends StatefulWidget {
  const TelaProduto({Key? key}) : super(key: key);

  @override
  State<TelaProduto> createState() => _TelaProdutoState();
}

class _TelaProdutoState extends State<TelaProduto>
    with SingleTickerProviderStateMixin {
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

  void _swapModal() {
    setState(() {
      if (!openedModal) {
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
      title: Text(
        produto.nome,
        style: GoogleFonts.keaniaOne(
          fontSize: 30,
        ),
      ),
    );

    final totalHeight = MediaQuery.of(context).size.height;
    final appBarHeight =
        appBar.preferredSize.height + MediaQuery.of(context).padding.top;
    final availableHeight = totalHeight - appBarHeight;
    final double maxHeight = (isEditing) ? 0.47 : 0.40;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      floatingActionButton: (provider.emptyList)
          ? null
          : FloatingActionButton(
              mini: true,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
            child: Column(
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CardIngrediente(
                      urlImage: 'images/pao.png',
                      text: 'Pão',
                    ),
                    CardIngrediente(
                      urlImage: 'images/carne.jpg',
                      text: 'Carne',
                    ),
                  ],
                ),
                const CardIngrediente(
                  urlImage: 'images/ingredientes.png',
                  text: 'Ingredientes do Hambúrguer',
                  imageRatioWidth: 0.30,
                  textRatioWidth: 0.65,
                  ratioWidth: 0.92,
                ),
              ],
            ),
          ),
          /*
          * Modal
          */
          AnimatedContainer(
            duration: _duration,
            height: availableHeight * (openedModal ? maxHeight : 0.07),
            // height: availableHeight * maxHeight,
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
                        onPressed: _swapModal,
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
                      child: ModalProduto(
                        produto: produto,
                        onTapEdit: null, // TODO: juao -> Mexe nesse onTapEdit
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
                            _swapModal();
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
                                duration: const Duration(milliseconds: 1500),
                              ),
                            );
                          }
                        },
                        isEditing: isEditing,
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
