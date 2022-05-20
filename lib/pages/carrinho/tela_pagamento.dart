import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/combo_box.dart';
import 'package:garagem_burger/components/row_price.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:garagem_burger/controllers/provider_cartoes.dart';
import 'package:garagem_burger/controllers/provider_pedidos.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/pages/cartoes/tela_novo_cartao.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TelaPagamento extends StatefulWidget {
  const TelaPagamento({Key? key}) : super(key: key);

  @override
  State<TelaPagamento> createState() => _TelaPagamentoState();

  @override
  String toStringShort() => 'Pagamento';
}

class _TelaPagamentoState extends State<TelaPagamento> {
  bool isPix = false;
  bool updatedCard = false;
  bool isNewCard = false;
  bool isLoading = false;
  String? currentCardId;

  Future<void> _efetuarPedido(BuildContext context) async {
    final pvdCarrinho = Provider.of<ProviderCarrinho>(
      context,
      listen: false,
    );
    final pvdPedido = Provider.of<ProviderPedidos>(
      context,
      listen: false,
    );
    final user = Provider.of<ProviderUsuario>(
      context,
      listen: false,
    ).usuario;

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
      arguments: pvdPedido.pedidos.values.last,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pvdCarrinho = Provider.of<ProviderCarrinho>(context);
    final pvdCartao = Provider.of<ProviderCartoes>(context);
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
                    onPressed: () {
                      setState(() => isPix = true);
                    },
                    icon: const Icon(Icons.pix),
                    iconSize: 50,
                    color: (isPix) ? Colors.blue : Colors.black,
                  ),
                  Text(
                    'PIX',
                    style: GoogleFonts.oxygen(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: (isPix) ? Colors.blue : Colors.black,
                    ),
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
                  Text(
                    'Cartão',
                    style: GoogleFonts.oxygen(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: (!isPix) ? Colors.blue : Colors.black,
                    ),
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
                    Text(
                      '\nSelecione um cartão cadastrado',
                      style: GoogleFonts.oxygen(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '\nou',
                      style: GoogleFonts.oxygen(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
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
                          isNewCard = (isSubmit as bool);
                          updatedCard = !isNewCard;
                        });
                      },
                      child: Text(
                        'Insira outro cartão',
                        style: GoogleFonts.oxygen(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
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
                  title: Text(
                    'Pagamento - Chave PIX',
                    style: GoogleFonts.oxygen(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '95.752.445/0001-34',
                    style: GoogleFonts.oxygen(
                      fontSize: 18,
                    ),
                  ),
                  trailing: IconButton(
                    // TODO: Copiar o subtitle para a área de transferência
                    onPressed: () {},
                    icon: const Icon(Icons.copy),
                  ),
                ),
              ),
            ),
          ),
        /*
        * Total
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
                    onPressed: () => _efetuarPedido(context),
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
