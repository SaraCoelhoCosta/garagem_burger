import 'package:flutter/material.dart';
import 'package:garagem_burger/components/card_cartao.dart';
import 'package:garagem_burger/pages/cartoes/tela_novo_cartao.dart';
import 'package:garagem_burger/pages/tela_vazia.dart';
import 'package:garagem_burger/providers/provider_cartao.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TelaMeusCartoes extends StatelessWidget {
  const TelaMeusCartoes({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Meus Cartões';

  Widget _buildTela(BuildContext context) {
    final provider = Provider.of<ProviderCartao>(
      context,
      listen: false,
    );
    return ListView(
      children: [
        const SizedBox(height: 10),
        // Botão adicionar novo cartão
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: () => Navigator.of(context).pushNamed(
                Rotas.main,
                arguments: [3, const TelaNovoCartao()],
              ),
              label: Text('Adicionar novo cartão',
                  style: GoogleFonts.oxygen(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.left),
              icon: const Icon(
                Icons.add_card_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Column(
          children: provider.listaCartoes
              .map((cartao) => CardCartao(cartao: cartao))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTelaVazia(BuildContext context) {
    return TelaVazia(
      pageName: 'Meus cartões',
      icon: Icons.credit_card,
      titulo: 'Adicionar novo cartão',
      subtitulo: 'Você ainda não possui um cartão cadastrado.',
      rodape: '',
      navigator: () => Navigator.of(context).pushNamed(
        Rotas.main,
        arguments: [3, const TelaNovoCartao()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderCartao>(context);
    return (provider.qntCartoes == 0)
        ? _buildTelaVazia(context)
        : _buildTela(context);
  }
}
