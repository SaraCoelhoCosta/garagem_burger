import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao_amarelo.dart';
import 'package:garagem_burger/components/campo_texto.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaNovaLocalizacao extends StatefulWidget {
  const TelaNovaLocalizacao({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Nova localização';

  @override
  State<TelaNovaLocalizacao> createState() => _TelaNovaLocalizacaoState();
}

class _TelaNovaLocalizacaoState extends State<TelaNovaLocalizacao> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 6.0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Novo endereço",
                        // Fonte do Google.
                        style: GoogleFonts.oxygen(
                          fontSize: 20, // Tamanho da fonte.
                          fontWeight: FontWeight.bold, // Largura da fonte.
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_location_alt_outlined,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        CampoTexto(
                          obscureText: false,
                          labelText: "Descrição",
                        ),
                        CampoTexto(
                          obscureText: false,
                          labelText: "CEP",
                        ),
                        CampoTexto(
                          obscureText: false,
                          labelText: "Rua",
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: CampoTexto(
                                obscureText: false,
                                labelText: "Bairro",
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: CampoTexto(
                                obscureText: false,
                                labelText: "Número",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: CampoTexto(
                                obscureText: false,
                                labelText: "Cidade",
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: CampoTexto(
                                obscureText: false,
                                labelText: "Estado",
                              ),
                            ),
                          ],
                        ),
                        CampoTexto(
                          obscureText: false,
                          labelText: "Complemento",
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Dica: Clicando no ícone ",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.oxygen(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  const Icon(Icons.add_location_alt_outlined),
                                ],
                              ),
                              Text(
                                " você pode adicionar um endereço a partir do mapa.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.oxygen(
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        BotaoAmarelo(
                          labelText: "Cadastrar endereço",
                          onPressed: () => {},
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Cancelar",
                            // Fonte do Google.
                            style: GoogleFonts.oxygen(
                              fontSize: 15, // Tamanho da fonte.
                              //fontWeight: FontWeight.bold, // Largura da fonte.
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
