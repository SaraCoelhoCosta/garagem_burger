import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/campo_texto.dart';
import 'package:garagem_burger/controllers/provider_localizacoes.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/models/localizacao.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class TelaAlterarLocalizacao extends StatefulWidget {
  final Localizacao localizacao;

  const TelaAlterarLocalizacao(
    this.localizacao, {
    Key? key,
  }) : super(key: key);

  @override
  String toStringShort() => 'Alterar localização';

  @override
  State<TelaAlterarLocalizacao> createState() => _TelaAlterarLocalizacaoState();
}

class _TelaAlterarLocalizacaoState extends State<TelaAlterarLocalizacao> {
  // Chave do formulário
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

  @override
  void initState() {
    _descricao.text = widget.localizacao.descricao!;
    _cep.text = widget.localizacao.cep;
    _rua.text = widget.localizacao.rua;
    _bairro.text = widget.localizacao.bairro;
    _numero.text = widget.localizacao.numero;
    _cidade.text = widget.localizacao.cidade;
    _estado.text = widget.localizacao.estado;
    _complemento.text = widget.localizacao.complemento!;
    super.initState();
  }

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

  Future<void> alterarLocalizacao(BuildContext context) async {
    final user = Provider.of<ProviderUsuario>(
      context,
      listen: false,
    ).usuario;
    try {
      await context
          .read<ProviderLocalizacoes>()
          .updateLocation(user, widget.localizacao)
          .then((_) {
        Navigator.of(context).pop(true);
      });
    } on Exception catch (e) {
      // TODO: Arrumar exceção.
      // ignore: avoid_print
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao alterar endereço"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 6.0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Alterar endereço",
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
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CampoTexto(
                          obscureText: false,
                          labelText: "Descrição",
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_campoCep);
                          },
                          textInputAction: TextInputAction.next,
                          focusNode: null,
                          controller: _descricao,
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                        CampoTexto(
                          obscureText: false,
                          labelText: "CEP",
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_campoRua);
                          },
                          textInputAction: TextInputAction.next,
                          focusNode: _campoCep,
                          keyboardType: TextInputType.number,
                          controller: _cep,
                          inputFormatters: [mascaraCep],
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return 'Campo obrigatório';
                            } else if (value.trim().length < 8) {
                              return 'CEP inválido';
                            }
                            return null;
                          },
                        ),
                        CampoTexto(
                          obscureText: false,
                          labelText: "Rua",
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_campoBairro);
                          },
                          textInputAction: TextInputAction.next,
                          focusNode: _campoRua,
                          controller: _rua,
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: CampoTexto(
                                obscureText: false,
                                labelText: "Bairro",
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_campoNumero);
                                },
                                textInputAction: TextInputAction.next,
                                focusNode: _campoBairro,
                                controller: _bairro,
                                validator: (String? value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: CampoTexto(
                                obscureText: false,
                                labelText: "Número",
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_campoCidade);
                                },
                                textInputAction: TextInputAction.next,
                                focusNode: _campoNumero,
                                controller: _numero,
                                validator: (String? value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Campo obrigatório';
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
                              flex: 5,
                              child: CampoTexto(
                                obscureText: false,
                                labelText: "Cidade",
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_campoEstado);
                                },
                                textInputAction: TextInputAction.next,
                                focusNode: _campoCidade,
                                controller: _cidade,
                                validator: (String? value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: CampoTexto(
                                obscureText: false,
                                labelText: "Estado",
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_campoComplemento);
                                },
                                textInputAction: TextInputAction.next,
                                focusNode: _campoEstado,
                                controller: _estado,
                                validator: (String? value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Campo obrigatório';
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
                          onFieldSubmitted: (_) => {
                            if (_formKey.currentState!.validate())
                              {
                                widget.localizacao.cep = _cep.text,
                                widget.localizacao.rua = _rua.text,
                                widget.localizacao.bairro = _bairro.text,
                                widget.localizacao.cidade = _cidade.text,
                                widget.localizacao.estado = _estado.text,
                                widget.localizacao.numero = _numero.text,
                                widget.localizacao.descricao = _descricao.text,
                                widget.localizacao.complemento =
                                    _complemento.text,
                                alterarLocalizacao(context),
                              },
                          },
                          textInputAction: TextInputAction.done,
                          focusNode: _campoComplemento,
                          controller: _complemento,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Dica: Clicando no ícone ",
                                  style: GoogleFonts.oxygen(
                                    fontSize: 14.0,
                                  ),
                                ),
                                const Icon(Icons.add_location_alt_outlined),
                              ],
                            ),
                            Text(
                              " você pode adicionar um endereço a partir do mapa.",
                              style: GoogleFonts.oxygen(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        Botao(
                          labelText: "Alterar endereço",
                          onPressed: () => {
                            if (_formKey.currentState!.validate())
                              {
                                widget.localizacao.cep = _cep.text,
                                widget.localizacao.rua = _rua.text,
                                widget.localizacao.bairro = _bairro.text,
                                widget.localizacao.cidade = _cidade.text,
                                widget.localizacao.estado = _estado.text,
                                widget.localizacao.numero = _numero.text,
                                widget.localizacao.descricao = _descricao.text,
                                widget.localizacao.complemento =
                                    _complemento.text,
                                alterarLocalizacao(context),
                              },
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
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
