// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, sized_box_for_whitespace, avoid_print, prefer_collection_literals, override_on_non_overriding_member, unused_import
import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/controllers/auth_service.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:garagem_burger/components/campo_texto.dart';
import 'package:google_fonts/google_fonts.dart';
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
  var mascaraTelefone = new MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  // Campos de texto.
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _telefone = TextEditingController();
  final _senha = TextEditingController();
  final _confirmarSenha = TextEditingController();

  // Flag para senha.
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
          .read<AuthService>()
          .registrar(_email.text, _senha.text, dadosUsuario!);
    } on AuthException catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pega tamanho da tela.
    Size tamanho = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xfffed80b), // Cor de fundo.

      body: ListView(
        children: <Widget>[
          // Espaçamento vertical início da tela e imagem.
          SizedBox(height: tamanho.height * 0.04),

          // Imagem.
          Container(
            // Largura e altura.
            width: 175,
            height: 175,

            // Imagem.
            child: Image.asset(
              "./images/logoHamburgueria.png",
            ),
          ),

          // Texto.
          Center(
            child: Text(
              "Cadastro",
              style: TextStyle(
                fontFamily: "Oxygen", // Tipo de fonte.
                fontSize: 30, // Tamanho da fonte.
                fontWeight: FontWeight.bold, // Largura da fonte.
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            // Formulário.
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Campo de nome.
                  CampoTexto(
                    // Nome do campo.
                    labelText: 'Nome',

                    // Icone perfixo.
                    prefixIcon: Icon(Icons.person),

                    // Oculta texto.
                    obscureText: false,

                    // Define o tipo de entrada do campo.
                    keyboardType: TextInputType.name,

                    // Aponta para o próximo campo de entrada.
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_campoEmail);
                    },

                    // O botão de enter leva para o próximo campo.
                    textInputAction: TextInputAction.next,

                    // Indica qual é o campo.
                    focusNode: null,

                    // Formato/máscara do campo.
                    inputFormatters: null,

                    controller: _nome,

                    // Validação do campo.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe seu nome';
                      }
                      return null;
                    },
                  ),

                  // Campo de e-mail.
                  CampoTexto(
                    // Campo de texto "E-mail".
                    labelText: 'E-mail',

                    // Icone prefixo.
                    prefixIcon: Icon(Icons.email),

                    // Define o tipo de entrada do campo.
                    keyboardType: TextInputType.emailAddress,

                    // Indica qual é o campo.
                    focusNode: _campoEmail,

                    // Aponta para o próximo campo de entrada.
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_campoTelefone);
                    },

                    // O botão de enter leva para o próximo campo.
                    textInputAction: TextInputAction.next,

                    // Oculta o texto.
                    obscureText: false,

                    controller: _email,

                    // Validação do campo.
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Informe seu e-mail corretamente';
                      }
                      return null;
                    },
                  ),

                  // Campo de telefone.
                  CampoTexto(
                    // Campo de texto "Telefone".
                    labelText: 'Telefone',

                    // Icone prefixo.
                    prefixIcon: Icon(Icons.phone),

                    // Define o tipo de entrada do campo.
                    keyboardType: TextInputType.number,

                    // Máscara do telefone.
                    inputFormatters: [mascaraTelefone],

                    // Indica qual é o campo.
                    focusNode: _campoTelefone,

                    // Aponta para o próximo campo de entrada.
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_campoSenha);
                    },

                    // O botão de enter leva para o próximo campo.
                    textInputAction: TextInputAction.next,

                    // Oculta o texto.
                    obscureText: false,

                    controller: _telefone,

                    // Validação do campo.
                    validator: (value) {
                      if (value!.isEmpty || value.length < 11) {
                        return 'Informe seu telefone';
                      }
                      return null;
                    },
                  ),

                  CampoTexto(
                    // Campo de texto "Senha".
                    labelText: 'Senha',

                    // Icone prefixo.
                    prefixIcon: Icon(Icons.lock),
                    // Icone com ação. - suffixIcon: IconButton(onPressed: () => {}, icon: Icon(Icons.remove_red_eye),),

                    // Icone sufixo (exibir senha)
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
                    // Indica qual é o campo.
                    focusNode: _campoSenha,

                    // Aponta para o próximo campo de entrada.
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_campoConfirmarSenha);
                    },

                    // O botão de enter leva para o próximo campo.
                    textInputAction: TextInputAction.next,

                    // Oculta texto.
                    obscureText: !exibirSenha,

                    controller: _senha,

                    // Validação do campo.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informa sua senha';
                      } else if (value.length < 6) {
                        return 'Sua senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                  ),

                  // Campo de confirmar senha.
                  CampoTexto(
                    // Campo de texto "Confirmar Senha".
                    labelText: 'Confirmar Senha',

                    // Icone prefixo.
                    prefixIcon: Icon(Icons.lock),

                    // Icone sufixo (exibir senha)
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

                    // Indica qual é o campo.
                    focusNode: _campoConfirmarSenha,

                    // O botão de enter realiza cadastro.
                    textInputAction: TextInputAction.done,

                    // Chama a função para concluir cadastro.
                    onFieldSubmitted: (_) => {},

                    // Oculta texto.
                    obscureText: !exibirSenha,

                    controller: _confirmarSenha,

                    // Validação do campo.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informa sua confirmação de senha';
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

          Botao(
            internalPadding: const EdgeInsets.symmetric(vertical: 15),
            externalPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            loading: (_loading) ? true : false,
            labelText: "Cadastrar",
            onPressed: () => {
              if (_formKey.currentState!.validate())
                {
                  dadosUsuario = {
                    "nome": _nome.text,
                    "email": _email.text,
                    "telefone": _telefone.text,
                  },
                  efetuarCadastro(),
                },
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Texto.
              Text(
                "Já possui cadastro?",
                // Fonte do Google.
                style: GoogleFonts.oxygen(
                  fontSize: 18, // Tamanho da fonte.
                  fontWeight: FontWeight.w500, // Largura da fonte.
                ),
              ),

              // Botão em forma de texto.
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),

                // Texto do botão.
                child: Text(
                  'Login',
                  // Fonte do Google.
                  style: GoogleFonts.oxygen(
                    fontSize: 18, // Tamanho da fonte.
                    color: Colors.blue, // Cor da fonte.
                    fontWeight: FontWeight.bold, // Largura da fonte.
                  ),
                ),

                // Ação executada pelo botão.
                onPressed: () {
                  Provider.of<AuthService>(
                    context,
                    listen: false,
                  ).switchAuthPage();
                  // Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
