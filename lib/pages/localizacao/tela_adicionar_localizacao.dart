import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/pages/localizacao/tela_nova_localizacao.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaAdicionarLocalizacao extends StatefulWidget {
  const TelaAdicionarLocalizacao({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Endereço de entrega';

  @override
  State<TelaAdicionarLocalizacao> createState() =>
      _TelaAdicionarLocalizacaoState();
}

class _TelaAdicionarLocalizacaoState extends State<TelaAdicionarLocalizacao> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            SizedBox(
              height: 10,
            ),
          ],
        ),
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: const [
                      SizedBox(
                        height: 1,
                      ),
                    ],
                  ),
                  const Text(
                    '\nEndereço de entrega\n',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    '\nComboBox\n',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    '\nSelecione um endereço cadastrado',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'ou',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed(
                      Rotas.main,
                      arguments: [2, const TelaNovaLocalizacao()],
                    ),
                    child: Text('insira outro endereço',
                        style: GoogleFonts.oxygen(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.left),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: const [
                      SizedBox(
                        height: 1,
                      ),
                    ],
                  ),
                  const Text(
                    '\nSub Total -------------------------------- R\$ 88,00\n'
                    '\nFrete ------------------------------------- R\$ 7,00\n'
                    '\nTotal ------------------------------------- R\$ 95,00\n',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Botao(
                      labelText: 'Confirmar',
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
