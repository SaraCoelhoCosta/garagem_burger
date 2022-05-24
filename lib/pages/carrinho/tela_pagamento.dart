import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/combo_box.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/components/row_price.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:garagem_burger/controllers/provider_cartoes.dart';
import 'package:garagem_burger/controllers/provider_pedidos.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/pages/cartoes/tela_novo_cartao.dart';
import 'package:garagem_burger/utils/payment.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:provider/provider.dart';
import 'package:mercadopago_transparent/mercadopago_transparent.dart'
    as mercadopago;

class TelaPagamento extends StatefulWidget {
  const TelaPagamento({Key? key}) : super(key: key);

  @override
  State<TelaPagamento> createState() => _TelaPagamentoState();

  @override
  String toStringShort() => 'Pagamento';
}

class _TelaPagamentoState extends State<TelaPagamento> {
  final mercado = mercadopago.MercadoPago(
    acessToken: Payment.accessToken,
    publicKey: Payment.publicKey,
    applicationId: Payment.applicationId,
  );
  mercadopago.Payment? pay;

  bool isPix = false;
  bool updatedCard = false;
  bool isNewCard = false;
  bool isLoading = false;
  String? currentCardId;
  String? status;
  int primeiraVez = 0;

  Future<void> _efetuarPedido(BuildContext context) async {
    final pvdCarrinho = Provider.of<ProviderCarrinho>(context, listen: false);
    final pvdPedido = Provider.of<ProviderPedidos>(context, listen: false);
    final user = Provider.of<ProviderUsuario>(context, listen: false).usuario;

    setState(() => isLoading = true);
    pvdPedido.setMetodoPagamento(isPix ? 'Pix' : 'Cartão');

    await pvdPedido.addPedido(
      user,
      pvdCarrinho.itensCarrinho.values.toList(),
      pvdCarrinho.precoTotal,
    );
    pvdCarrinho.clearAll();
    setState(() => isLoading = false);
    Navigator.of(context).pushNamedAndRemoveUntil(
      Rotas.pedido,
      (_) => false,
      arguments: pvdPedido.pedidos.values.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pvdCarrinho = Provider.of<ProviderCarrinho>(context);
    final pvdCartao = Provider.of<ProviderCartoes>(context);
    final user = Provider.of<ProviderUsuario>(context).usuario;
    if (!updatedCard) {
      currentCardId = (isNewCard)
          ? pvdCartao.cartoes.keys.last
          : pvdCartao.favoriteCartao?.id;
      updatedCard = true;
    }
    return Column(
      children: [
        /*
        * Switch Pix ~ Cartão
        */
        Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /*
              * Botão PIX
              */
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    //TODO: Pix vai manter, né? Vi dizerem que estava funcionando
                    onPressed: () async {
                      setState(() => isPix = true);
                      if (primeiraVez < 1) {
                        pay = await mercado.payment.pix(
                          amount: 0.01,
                          name: user!.displayName ?? "",
                          email: user.email ?? "",
                          docNumber: '',
                        );
                      }
                      primeiraVez++;
                    },
                    icon: const Icon(Icons.pix),
                    iconSize: 50,
                    color: (isPix) ? Colors.blue : Colors.black,
                  ),
                  CustomText(
                    'PIX',
                    fontWeight: FontWeight.bold,
                    color: (isPix) ? Colors.blue : Colors.black,
                    fontSize: 20,
                  ),
                ],
              ),
              /*
              * Botão Cartão
              */
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() => isPix = false);
                    },
                    icon: const Icon(Icons.credit_card),
                    iconSize: 50,
                    color: (!isPix) ? Colors.blue : Colors.black,
                  ),
                  CustomText(
                    'Cartão',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: (!isPix) ? Colors.blue : Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
        /*
        * Selecionar cartão
        */
        if (!isPix)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ComboBox(
                      //TODO: Diacho de comboBox também não funciona aqui
                      // *não tá pegando os cartões já cadastrados*
                      value: currentCardId,
                      items: pvdCartao.cartoes.values.map((cartao) {
                        return {
                          'id': cartao.id,
                          'descricao': cartao.descricao,
                        };
                      }).toList(),
                      onChanged: (String? selectedCardId) {
                        setState(() {
                          currentCardId = selectedCardId!;
                        });
                      },
                    ),
                    const CustomText(
                      '\nSelecione um cartão cadastrado\n\nou',
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          Rotas.main,
                          arguments: {
                            'index': 2,
                            'page': const TelaNovoCartao(),
                            'button': null,
                          },
                        ).then((isSubmit) {
                          if (isSubmit != null) {
                            isNewCard = (isSubmit as bool);
                            updatedCard = !isNewCard;
                          }
                        });
                      },
                      child: const CustomText(
                        'Insira outro cartão',
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        /*
        * Selecionar PIX
        */
        if (isPix)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: const CustomText(
                    'Pagamento - Chave PIX',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: CustomText(
                    pay?.qrCode ?? "",
                    color: Colors.grey,
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.copy),
                  ),
                ),
              ),
            ),
          ),
        /*
        * Total e botão de confirmar
        */
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RowPrice(
                    text: 'Total',
                    value: pvdCarrinho.precoTotal,
                  ),
                  Botao(
                    labelText: 'Confirmar',
                    loading: isLoading,
                    externalPadding: const EdgeInsets.only(top: 10),
                    onPressed: () async => {
                      /*setState(() => status = pay!.status),
                                print(pay?.qrCode), // TODO: teste (chave pix)
                                print(status), // TODO: status do pagamento
                                if (status == "accredited")
                                  {
                                    _efetuarPedido(context),
                                  }
                                else
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: CustomText(
                                            'Faça o pagamento primeiro para continuar'),
                                        backgroundColor: Colors.red,
                                      ),
                                    )
                                  }
                              }
                            else*/
                      await Future.delayed(const Duration(seconds: 5)),
                      await _efetuarPedido(context),
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
