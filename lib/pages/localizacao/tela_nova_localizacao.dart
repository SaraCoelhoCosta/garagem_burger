import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/campo_texto.dart';
import 'package:garagem_burger/controllers/provider_localizacoes.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class TelaNovaLocalizacao extends StatefulWidget {
  const TelaNovaLocalizacao({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Nova localização';

  @override
  State<TelaNovaLocalizacao> createState() => _TelaNovaLocalizacaoState();
}

class _TelaNovaLocalizacaoState extends State<TelaNovaLocalizacao> {
  // Chave do formulário.
  final _formKey = GlobalKey<FormState>();

  // Campos que estão com foco.
  final _campoCep = FocusNode();
  final _campoRua = FocusNode();
  final _campoBairro = FocusNode();
  final _campoNumero = FocusNode();
  final _campoCidade = FocusNode();
  final _campoEstado = FocusNode();
  final _campoComplemento = FocusNode();

  // Máscara para cep.
  var mascaraCep = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  // Campos de texto.
  final _descricao = TextEditingController();
  final _cep = TextEditingController();
  final _rua = TextEditingController();
  final _bairro = TextEditingController();
  final _numero = TextEditingController();
  final _cidade = TextEditingController();
  final _estado = TextEditingController();
  final _complemento = TextEditingController();

  bool _loading = false;

  late Map<String, dynamic> dadosLocalizacao;

  // Libera os recursos após sair da tela ou salvar os dados.
  @override
  void dispose() {
    super.dispose();
    _campoRua.dispose();
    _campoBairro.dispose();
    _campoCep.dispose();
    _campoCidade.dispose();
    _campoEstado.dispose();
    _campoNumero.dispose();
    _campoComplemento.dispose();
  }

  Future<void> addLocalizacao(BuildContext context) async {
    final user = Provider.of<ProviderUsuario>(
      context,
      listen: false,
    ).usuario;
    setState(() => _loading = true);
    try {
      await context
          .read<ProviderLocalizacoes>()
          .addLocation(user, dadosLocalizacao)
          .then((_) {
        Navigator.of(context).pop(true);
      });
    } on Exception catch (e) {
      // TODO: Arrumar exceção.
      setState(() => _loading = false);
      // ignore: avoid_print
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Erro ao cadastrar endereço",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pvdLocal = Provider.of<ProviderLocalizacoes>(context);
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
                        style: GoogleFonts.oxygen(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // TODO: selecionar endereço pelo maps
                        },
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
                    key: _formKey,
                    child: Column(
                      children: [
                        CampoTexto(
                          obscureText: false,
                          labelText: "Descrição",
                          // Aponta para o próximo campo de entrada.
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_campoCep);
                          },

                          // O botão de enter leva para o próximo campo.
                          textInputAction: TextInputAction.next,

                          // Indica qual é o campo.
                          focusNode: null,

                          controller: _descricao,
                        ),
                        CampoTexto(
                          obscureText: false,
                          labelText: "CEP",
                          // Aponta para o próximo campo de entrada.
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_campoRua);
                          },

                          // O botão de enter leva para o próximo campo.
                          textInputAction: TextInputAction.next,

                          // Indica qual é o campo.
                          focusNode: _campoCep,

                          // Define o tipo de entrada do campo.
                          keyboardType: TextInputType.number,

                          controller: _cep,

                          // Formato/máscara do campo.
                          inputFormatters: [mascaraCep],

                          // Validação do campo.
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o número do seu CEP';
                            }
                            return null;
                          },
                        ),
                        CampoTexto(
                          obscureText: false,
                          labelText: "Rua",

                          // Aponta para o próximo campo de entrada.
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_campoBairro);
                          },

                          // O botão de enter leva para o próximo campo.
                          textInputAction: TextInputAction.next,

                          // Indica qual é o campo.
                          focusNode: _campoRua,

                          controller: _rua,

                          // Validação do campo.
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o nome da sua rua';
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CampoTexto(
                                obscureText: false,
                                labelText: "Bairro",

                                // Aponta para o próximo campo de entrada.
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_campoNumero);
                                },

                                // O botão de enter leva para o próximo campo.
                                textInputAction: TextInputAction.next,

                                // Indica qual é o campo.
                                focusNode: _campoBairro,

                                controller: _bairro,

                                // Validação do campo.
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Informe o nome do seu bairro';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              child: CampoTexto(
                                obscureText: false,
                                labelText: "Número",
                                // Aponta para o próximo campo de entrada.
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_campoCidade);
                                },

                                // O botão de enter leva para o próximo campo.
                                textInputAction: TextInputAction.next,

                                // Indica qual é o campo.
                                focusNode: _campoNumero,

                                controller: _numero,

                                // Validação do campo.
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Informe o número do seu endereço';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CampoTexto(
                                obscureText: false,
                                labelText: "Cidade",

                                // Aponta para o próximo campo de entrada.
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_campoEstado);
                                },

                                // O botão de enter leva para o próximo campo.
                                textInputAction: TextInputAction.next,

                                // Indica qual é o campo.
                                focusNode: _campoCidade,

                                controller: _cidade,

                                // Validação do campo.
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Informe o nome da sua cidade';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              child: CampoTexto(
                                obscureText: false,
                                labelText: "Estado",
                                // Aponta para o próximo campo de entrada.
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_campoComplemento);
                                },

                                // O botão de enter leva para o próximo campo.
                                textInputAction: TextInputAction.next,

                                // Indica qual é o campo.
                                focusNode: _campoEstado,

                                controller: _estado,

                                // Validação do campo.
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Informe nome do seu estado';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        CampoTexto(
                          obscureText: false,
                          labelText: "Complemento",

                          // Aponta para o próximo campo de entrada.
                          onFieldSubmitted: (_) => {
                            if (_formKey.currentState!.validate())
                              {
                                dadosLocalizacao = {
                                  "cep": _cep.text,
                                  "rua": _rua.text,
                                  "bairro": _bairro.text,
                                  "cidade": _cidade.text,
                                  "estado": _estado.text,
                                  "numero": _numero.text,
                                  "descricao": _descricao.text,
                                  "complemento": _complemento.text,
                                  "favorito": pvdLocal.emptyList,
                                },
                                addLocalizacao(context),
                              },
                          },

                          // O botão de enter leva para o próximo campo.
                          textInputAction: TextInputAction.done,

                          // Indica qual é o campo.
                          focusNode: _campoComplemento,

                          controller: _complemento,
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
                        Botao(
                          labelText: "Cadastrar endereço",
                          loading: _loading,
                          onPressed: () => {
                            if (_formKey.currentState!.validate())
                              {
                                dadosLocalizacao = {
                                  "cep": _cep.text,
                                  "rua": _rua.text,
                                  "bairro": _bairro.text,
                                  "cidade": _cidade.text,
                                  "estado": _estado.text,
                                  "numero": _numero.text,
                                  "descricao": _descricao.text,
                                  "complemento": _complemento.text,
                                  "favorito": pvdLocal.emptyList,
                                },
                                addLocalizacao(context),
                              },
                          },
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
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
