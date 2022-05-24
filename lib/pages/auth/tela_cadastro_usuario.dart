import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/pages/menu/tela_menu.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:garagem_burger/components/custom_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class TelaCadastroUsuario extends StatefulWidget {
  const TelaCadastroUsuario({Key? key}) : super(key: key);

  @override
  _TelaCadastroUsuarioState createState() => _TelaCadastroUsuarioState();
}

class _TelaCadastroUsuarioState extends State<TelaCadastroUsuario> {
  // Chave do formulário.
  final _formKey = GlobalKey<FormState>();

  // Campos que estão com foco.
  final _campoEmail = FocusNode();
  final _campoTelefone = FocusNode();
  final _campoSenha = FocusNode();
  final _campoConfirmarSenha = FocusNode();

  // Máscara para telefone.
  var mascaraTelefone = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  // Campos de texto.
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _telefone = TextEditingController();
  final _senha = TextEditingController();
  final _confirmarSenha = TextEditingController();

  // Flags
  bool exibirSenha = false;
  bool _loading = false;

  Map<String, dynamic>? dadosUsuario;

  // Libera os recursos após sair da tela ou salvar os dados.
  @override
  void dispose() {
    super.dispose();
    _campoEmail.dispose();
    _campoTelefone.dispose();
    _campoSenha.dispose();
    _campoConfirmarSenha.dispose();
  }

  efetuarCadastro() async {
    setState(() => _loading = true);
    try {
      await context
          .read<ProviderUsuario>()
          .registrar(_email.text, _senha.text, dadosUsuario!);
      Navigator.of(context).pushReplacementNamed(
        Rotas.main,
        arguments: {
          'index': 0,
          'page': const TelaMenu(),
          'button': null,
        },
      );
    } on AuthException catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomText(e.message),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size tamanho = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xfffed80b),
      body: ListView(
        children: [
          SizedBox(height: tamanho.height * 0.04),
          /*
          * Imagem
          */
          SizedBox(
            width: 175,
            height: 175,
            child: Image.asset(
              './images/logoHamburgueria.png',
            ),
          ),
          /*
          * Titulo
          */
          const Center(
            child: CustomText(
              'Cadastro',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          /*
          * Formulário
          */
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /*
                  * Campo de nome
                  */
                  CustomTextField(
                    labelText: 'Nome',
                    prefixIcon: const Icon(Icons.person),
                    keyboardType: TextInputType.name,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_campoEmail);
                    },
                    textInputAction: TextInputAction.next,
                    focusNode: null,
                    inputFormatters: null,
                    controller: _nome,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  /*
                  * Campo de email
                  */
                  CustomTextField(
                    labelText: 'E-mail',
                    prefixIcon: const Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _campoEmail,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_campoTelefone);
                    },
                    textInputAction: TextInputAction.next,
                    controller: _email,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Campo obrigatório';
                      } else if (!value.contains('@') ||
                          value.trim().length < 10) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                  ),
                  /*
                  * Campo de telefone
                  */
                  CustomTextField(
                    labelText: 'Telefone',
                    prefixIcon: const Icon(Icons.phone),
                    keyboardType: TextInputType.number,
                    inputFormatters: [mascaraTelefone],
                    focusNode: _campoTelefone,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_campoSenha);
                    },
                    textInputAction: TextInputAction.next,
                    controller: _telefone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (value.length < 11) {
                        return 'Telefone inválido';
                      }
                      return null;
                    },
                  ),
                  /*
                  * Campo de senha
                  */
                  CustomTextField(
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        exibirSenha ? Icons.visibility : Icons.visibility_off,
                      ),
                      onTap: () {
                        setState(() {
                          exibirSenha = !exibirSenha;
                        });
                      },
                    ),
                    focusNode: _campoSenha,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_campoConfirmarSenha);
                    },
                    textInputAction: TextInputAction.next,
                    obscureText: !exibirSenha,
                    controller: _senha,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Campo obrigatório';
                      } else if (value.trim().length < 6) {
                        return 'Mínimo de 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  /*
                  * Campo de confirmar senha
                  */
                  CustomTextField(
                    labelText: 'Confirmar Senha',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      child: Icon(exibirSenha
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onTap: () {
                        setState(() {
                          exibirSenha = !exibirSenha;
                        });
                      },
                    ),
                    focusNode: _campoConfirmarSenha,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => {
                      if (_formKey.currentState!.validate())
                        {
                          dadosUsuario = {
                            'nome': _nome.text,
                            'email': _email.text,
                            'telefone': _telefone.text,
                          },
                          efetuarCadastro(),
                        },
                    },
                    obscureText: !exibirSenha,
                    controller: _confirmarSenha,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Campo obrigatório';
                      } else if (value.length < 6) {
                        return 'Sua senha deve ter no mínimo 6 caracteres';
                      } else if (_confirmarSenha.text != _senha.text) {
                        return 'As senhas são diferentes';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          /*
          * Botão de Cadastro
          */
          Botao(
            internalPadding: const EdgeInsets.symmetric(vertical: 15),
            externalPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            loading: _loading,
            labelText: 'Cadastrar',
            onPressed: () => {
              if (_formKey.currentState!.validate())
                {
                  dadosUsuario = {
                    'nome': _nome.text,
                    'email': _email.text,
                    'telefone': _telefone.text,
                  },
                  efetuarCadastro(),
                },
            },
          ),
          /*
          * Botão de login
          */
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                'Já possui cadastro?',
                fontWeight: FontWeight.w500,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                child: const CustomText(
                  'Login',
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Rotas.login);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
