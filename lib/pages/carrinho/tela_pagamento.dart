import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/row_price.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:provider/provider.dart';

class TelaPagamento extends StatefulWidget {
  const TelaPagamento({ Key? key }) : super(key: key);

  @override
  State<TelaPagamento> createState() => _TelaPagamentoState();

  @override
  String toStringShort() => 'Pagamento';
}

class _TelaPagamentoState extends State<TelaPagamento> {
  @override
  Widget build(BuildContext context) {
    final pvdCarrinho = Provider.of<ProviderCarrinho>(
      context,
      listen: false,
    );
    return Padding(
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
                    externalPadding: const EdgeInsets.only(top: 10),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        );
  }
}