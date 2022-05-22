import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/components/custom_text_field.dart';
import 'package:garagem_burger/controllers/provider_localizacoes.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
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
    filter: {'#': RegExp(r'[0-9]')},
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

  Map<String, dynamic> dadosLocalizacao = {
    'cep': '',
    'rua': '',
    'bairro': '',
    'cidade': '',
    'estado': '',
    'numero': '',
    'descricao': '',
    'complemento': '',
    'favorito': false,
  };

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
    } on Exception catch (_) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomText('Erro ao cadastrar endereço'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pvdLocal = Provider.of<ProviderLocalizacoes>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 6.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                /*
                * Title
                */
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        'Nova localização',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      IconButton(
                        onPressed: () {
                          // TODO: adicionar localização no mapa
                        },
                        icon: const Icon(
                          Icons.add_location_alt_outlined,
                        ),
                      ),
                    ],
                  ),
                ),
                /*
                * Formulário
                */
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        obscureText: false,
                        labelText: 'Descrição',
                        hintText:
                            'Minha localização ${pvdLocal.countLocations + 1}',
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_campoCep);
                        },
                        textInputAction: TextInputAction.next,
                        focusNode: null,
                        controller: _descricao,
                      ),
                      CustomTextField(
                        obscureText: false,
                        labelText: 'CEP',
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
                      CustomTextField(
                        obscureText: false,
                        labelText: 'Rua',
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
                            child: CustomTextField(
                              obscureText: false,
                              labelText: 'Bairro',
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
                            child: CustomTextField(
                              obscureText: false,
                              labelText: 'Número',
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
                            child: CustomTextField(
                              obscureText: false,
                              labelText: 'Cidade',
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
                            child: CustomTextField(
                              obscureText: false,
                              labelText: 'Estado',
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
                      CustomTextField(
                        obscureText: false,
                        labelText: 'Complemento',
                        onFieldSubmitted: (_) => {
                          if (_formKey.currentState!.validate())
                            {
                              dadosLocalizacao['cep'] = _cep.text,
                              dadosLocalizacao['rua'] = _rua.text,
                              dadosLocalizacao['bairro'] = _bairro.text,
                              dadosLocalizacao['cidade'] = _cidade.text,
                              dadosLocalizacao['estado'] = _estado.text,
                              dadosLocalizacao['numero'] = _numero.text,
                              dadosLocalizacao['descricao'] = (_descricao
                                      .text.isEmpty)
                                  ? 'Minha localização ${pvdLocal.countLocations + 1}'
                                  : _descricao.text,
                              dadosLocalizacao['complemento'] =
                                  _complemento.text,
                              dadosLocalizacao['favorito'] = pvdLocal.emptyList,
                              addLocalizacao(context),
                            },
                        },
                        textInputAction: TextInputAction.done,
                        focusNode: _campoComplemento,
                        controller: _complemento,
                      ),
                      /*
                      * Dicas
                      */
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                CustomText(
                                  'Dica: Clicando no ícone ',
                                  textAlign: TextAlign.center,
                                  fontSize: 15,
                                ),
                                Icon(Icons.add_location_alt_outlined),
                              ],
                            ),
                            const CustomText(
                              ' você pode adicionar um endereço a partir do mapa.',
                              textAlign: TextAlign.center,
                              fontSize: 15,
                            ),
                          ],
                        ),
                      ),
                      /*
                      * Botão de cadastrar
                      */
                      Botao(
                        labelText: 'Cadastrar endereço',
                        loading: _loading,
                        onPressed: () => {
                          if (_formKey.currentState!.validate())
                            {
                              dadosLocalizacao['cep'] = _cep.text,
                              dadosLocalizacao['rua'] = _rua.text,
                              dadosLocalizacao['bairro'] = _bairro.text,
                              dadosLocalizacao['cidade'] = _cidade.text,
                              dadosLocalizacao['estado'] = _estado.text,
                              dadosLocalizacao['numero'] = _numero.text,
                              dadosLocalizacao['descricao'] = (_descricao
                                      .text.isEmpty)
                                  ? 'Minha localização ${pvdLocal.countLocations + 1}'
                                  : _descricao.text,
                              dadosLocalizacao['complemento'] =
                                  _complemento.text,
                              dadosLocalizacao['favorito'] = pvdLocal.emptyList,
                              addLocalizacao(context),
                            },
                        },
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const CustomText(
                          'Cancelar',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
