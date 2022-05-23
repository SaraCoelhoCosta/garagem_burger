import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/components/order_status_row.dart';
import 'package:garagem_burger/components/popup_dialog.dart';
import 'package:garagem_burger/controllers/provider_pedidos.dart';
import 'package:garagem_burger/controllers/provider_produtos.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/models/pedido.dart';
import 'package:garagem_burger/pages/menu/tela_menu.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaPedido extends StatefulWidget {
  const TelaPedido({Key? key}) : super(key: key);

  @override
  State<TelaPedido> createState() => _TelaPedidoState();
}

class _TelaPedidoState extends State<TelaPedido> {
  bool canceling = false;
  bool showDetailPage = false;
  List<Map<String, dynamic>> panel = [
    {'index': 0, 'isExpanded': false},
    {'index': 1, 'isExpanded': false},
    {'index': 2, 'isExpanded': false},
  ];

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      title: const CustomText(
        'Acompanhar Pedido',
        fontSize: 30,
        fontType: FontType.title,
        color: Colors.white,
        bordered: true,
      ),
    );

    // Dados das rotas e providers
    final pedido = ModalRoute.of(context)!.settings.arguments as Pedido;
    final pvdPedido = Provider.of<ProviderPedidos>(context);
    final pvdProduto = Provider.of<ProviderProdutos>(context);
    final user = Provider.of<ProviderUsuario>(context).usuario;

    // Altura disponível
    final deviceSize = MediaQuery.of(context).size;
    final appBarHeight =
        appBar.preferredSize.height + MediaQuery.of(context).padding.top;
    final availableHeight = deviceSize.height - appBarHeight;

    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: true,
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
            /*
            * Etapas do pedido
            */
            SizedBox(height: appBarHeight),
            Container(
              height: availableHeight * 0.40,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: pedido.etapas.map((etapa) {
                      return OrderStatusRow(
                        date: etapa['date'] as DateTime,
                        isComplete: etapa['isComplete'] as bool,
                        isCanceled: pedido.status == Pedido.cancelado,
                        indexStatus: pedido.etapas.indexOf(etapa),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            /*
            * Detalhes do pedido
            */
            Container(
              height: availableHeight * 0.45,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: ExpansionPanelList(
                      expandedHeaderPadding: const EdgeInsets.only(bottom: 10),
                      expansionCallback: (panelIndex, isExpanded) {
                        setState(() {
                          panel[0]['isExpanded'] = isExpanded;
                          panel[1]['isExpanded'] = isExpanded;
                          panel[2]['isExpanded'] = isExpanded;
                          panel[panelIndex]['isExpanded'] = !isExpanded;
                        });
                      },
                      children: [
                        /*
                        * Itens do Pedido
                        */
                        ExpansionPanel(
                          canTapOnHeader: true,
                          backgroundColor: Colors.grey[100],
                          isExpanded: panel[0]['isExpanded'],
                          headerBuilder: (context, isExpanded) {
                            return const ListTile(
                              title: CustomText('Itens do Pedido'),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 6,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    CustomText('Itens'),
                                    CustomText('Valor'),
                                  ],
                                ),
                                const Divider(),
                                Column(
                                  children: pedido.itens.map((item) {
                                    final produto =
                                        pvdProduto.hamburguerById(item['id']);
                                    final qnt = item['quantidade'];
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          '${qnt}x ${produto.nome}',
                                        ),
                                        CustomText(
                                          'R\$ ${(qnt * produto.preco).toStringAsFixed(2)}',
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      'Total',
                                    ),
                                    CustomText(
                                      'R\$ ${(pedido.total).toStringAsFixed(2)}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        /*
                        * Endereço de entrega
                        */
                        ExpansionPanel(
                          canTapOnHeader: true,
                          backgroundColor: Colors.grey[100],
                          isExpanded: panel[1]['isExpanded'],
                          headerBuilder: (context, isExpanded) {
                            return const ListTile(
                              title: CustomText('Endereço de Entrega'),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 6,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    CustomText('Itens'),
                                    CustomText('Valor'),
                                  ],
                                ),
                                const Divider(),
                                Column(
                                  children: pedido.itens.map((item) {
                                    final produto =
                                        pvdProduto.hamburguerById(item['id']);
                                    final qnt = item['quantidade'];
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          '${qnt}x ${produto.nome}',
                                        ),
                                        CustomText(
                                          'R\$ ${(qnt * produto.preco).toStringAsFixed(2)}',
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                      'Total',
                                    ),
                                    CustomText(
                                      'R\$ ${(pedido.total).toStringAsFixed(2)}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            /*
            * Botão de cancelar
            */
            SizedBox(
              height: availableHeight * 0.10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Botao(
                  labelText: 'Cancelar',
                  loading: canceling,
                  disabled: !pedido.isCancelable,
                  externalPadding: const EdgeInsets.only(top: 20),
                  onPressed: (!pedido.isCancelable)
                      ? () {}
                      : () {
                          return showDialog(
                            context: context,
                            builder: (ctx) => PopupDialog(
                              titulo:
                                  'Tem certeza que deseja cancelar o pedido?',
                              yesLabel: 'Sim',
                              noLabel: 'Não',
                              onPressedYesOption: () =>
                                  Navigator.of(ctx).pop(true),
                              onPressedNoOption: () =>
                                  Navigator.of(ctx).pop(false),
                            ),
                          ).then((selectedYesOption) async {
                            if (selectedYesOption) {
                              setState(() => canceling = true);
                              await pvdPedido.cancelOrder(user, pedido);
                              // TODO: (Juao) => mostrar para o usuário que o pedido foi cancelado
                              setState(() => canceling = false);
                            }
                          });
                        },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xfffed80b),
        child: const Icon(Icons.home_rounded),
        foregroundColor: Colors.black,
        onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
          Rotas.main,
          (_) => false,
          arguments: {
            'index': 0,
            'page': const TelaMenu(),
            'button': null,
          },
        ),
      ),
    );
  }
}
