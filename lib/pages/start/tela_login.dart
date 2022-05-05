// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/controllers/auth_service.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:garagem_burger/components/campo_texto.dart';
import 'package:garagem_burger/pages/menu/tela_menu.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
// Chave do formulário.
  final _formKey = GlobalKey<FormState>();

  // Campos que estão com foco.
  final _campoSenha = FocusNode();

  // Flag para checkbox e senha.
  bool _isMarcado = false;
  bool _exibirSenha = false;

  // Mostrar estado durante a realização do login.
  bool _loading = false;

  // Campos de texto.
  final _email = TextEditingController();
  final _senha = TextEditingController();

  // Libera os recursos após sair da tela ou salvar os dados.
  @override
  void dispose() {
    super.dispose();
    _campoSenha.dispose();
  }

  login() async {
    setState(() => _loading = true);
    try {
      await context.read<AuthService>().login(_email.text, _senha.text);
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

          //Imagem.
          Container(
            // Largura e altura.
            width: 175,
            height: 175,

            // Imagem.
            child: Image.asset(
              "./images/logoHamburgueria.png",
            ),
          ),

          // Espaçamento vertical entre a imagem e o formulário.
          SizedBox(height: tamanho.height * 0.03),

          Padding(
            padding: const EdgeInsets.all(10.0),
            // Formulário.
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Campo e-mail.
                  CampoTexto(
                    // Campo de texto "E-mail".
                    labelText: 'E-mail',

                    // Icone prefixo.
                    prefixIcon: Icon(Icons.email),

                    // Define o tipo de entrada do campo.
                    keyboardType: TextInputType.emailAddress,

                    // Oculta texto.
                    obscureText: false,

                    // Aponta para o próximo campo de entrada.
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_campoSenha);
                    },

                    // O botão de enter leva para o próximo campo.
                    textInputAction: TextInputAction.next,

                    // Validação do campo.
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Informe o email corretamente!';
                      }
                      return null;
                    },

                    controller: _email,
                  ),

                  // Campo senha.
                  CampoTexto(
                    // Campo de texto "Senha".
                    labelText: 'Senha',

                    // Icone prefixo.
                    prefixIcon: Icon(Icons.lock),

                    // Icone sufixo (exibir senha)
                    suffixIcon: GestureDetector(
                      child: Icon(_exibirSenha
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onTap: () {
                        setState(() {
                          _exibirSenha = !_exibirSenha;
                        });
                      },
                    ),

                    // Oculta o texto.
                    obscureText: !_exibirSenha,

                    // Indica qual é o campo.
                    focusNode: _campoSenha,

                    // O botão de enter leva para o próximo campo.
                    textInputAction: TextInputAction.done,

                    // Validação do campo.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informa sua senha!';
                      } else if (value.length < 6) {
                        return 'Sua senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
                    },

                    controller: _senha,

                    // Ação realizada quando apertar o enter.
                    onFieldSubmitted: (_) => {
                      if (_formKey.currentState!.validate())
                        {
                          login(),
                        },
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              activeColor: Colors.black,
                              checkColor: Colors.white,
                              value: _isMarcado,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isMarcado = value!;
                                });
                              },
                            ),
                            Text(
                              "Mantenha-me conectado",
                              style:
                                  // Fonte do Google.
                                  GoogleFonts.oxygen(
                                color: Colors.blue, // Cor da fonte.
                                fontSize: 14, // Tamanho da fonte.
                                fontWeight:
                                    FontWeight.w500, // Largura da fonte.
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent),
                              child: Text(
                                'Esqueci minha senha',
                                style: // Fonte do Google.
                                    GoogleFonts.oxygen(
                                  color: Colors.blue, // Cor da fonte.
                                  fontSize: 14, // Tamanho da fonte.
                                  fontWeight:
                                      FontWeight.w500, // Largura da fonte.
                                ),
                              ),
                              onPressed: () {
                                /*
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TelaEsqueceuSenha(),
                                  ),
                                );*/
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
            labelText: "Entrar",
            onPressed: () => {
              _formKey.currentState!.validate() ? login() : null,
            },
          ),

          Botao(
            internalPadding: const EdgeInsets.symmetric(vertical: 15),
            externalPadding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 5,
            ),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            labelText: "Entrar como visitante",
            onPressed: () => Navigator.of(context).pushReplacementNamed(
              Rotas.main,
              arguments: [0, TelaMenu()],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Texto.
              Text(
                "Não tem conta?",
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
                  'Cadastre-se',
                  style: GoogleFonts.oxygen(
                    fontSize: 18, // Tamanho da fonte.
                    color: Colors.blue, // Cor da fonte.
                    fontWeight: FontWeight.bold, // Largura da fonte.
                  ),
                ),

                // Ação executada pelo botão.
                onPressed: () => Navigator.of(context).pushNamed(
                  Rotas.cadastro,
                ),
              ),
            ],
          ),

          // Espaçamento vertical entre link e o texto.
          SizedBox(height: tamanho.height * 0.05),

          Column(
            children: [
              Center(
                child: Text(
                  "Outras formas de login",
                  style: // Fonte do Google.
                      GoogleFonts.oxygen(
                    color: Colors.black, // Cor da fonte.
                    fontSize: 22, // Tamanho da fonte.
                    fontWeight: FontWeight.bold, // Largura da fonte.
                  ),
                ),
              ),

              // Espaçamento vertical entre texto e imagens.
              SizedBox(height: tamanho.height * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SignInButton.mini(
                    buttonType: ButtonType.google,
                    onPressed: () {},
                  ),
                  // Botão facebook.
                  SignInButton.mini(
                    buttonType: ButtonType.facebook,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
