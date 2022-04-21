// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:garagem_burger/controllers/login_usuario.dart';
import 'package:garagem_burger/screens/components/botao.dart';
import 'package:garagem_burger/screens/components/campo_texto.dart';
import 'package:garagem_burger/screens/teste.dart';
import 'package:garagem_burger/screens/tela_cadastroUsuario.dart';
//import 'package:garagem_burger/screens/tela_esqueceuSenha.dart';
import 'package:sign_button/sign_button.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  // Campos que estão com foco.
  final _campoSenha = FocusNode();

  // Flag para checkbox.
  bool isMarcado = false;

  // Controle para login.
  final _loginUsuario = LoginUsuario();

  // Libera os recursos após sair da tela ou salvar os dados.
  @override
  void dispose() {
    super.dispose();
    _campoSenha.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loginUsuario.outState.listen((estado) {
      switch (estado) {
        case EstadoLogin.SUCESSO:
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Tela()));
          break;
        case EstadoLogin.FALHA:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "E-mail ou senha inválidos",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            elevation: 6.0,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ));
          break;
        case EstadoLogin.CARREGANDO:
        case EstadoLogin.PARADO:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pega tamanho da tela.
    Size tamanho = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xfffed80b), // Cor de fundo.
      body: StreamBuilder<EstadoLogin>(
        stream: _loginUsuario.outState,
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case EstadoLogin.CARREGANDO:
              return Center(
                child: CircularProgressIndicator(),
              );
            case EstadoLogin.FALHA:
            case EstadoLogin.SUCESSO:
            case EstadoLogin.PARADO:
            default:
              return ListView(
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

                            // ??
                            onChanged: _loginUsuario.changeEmail,

                            // ??
                            stream: _loginUsuario.outEmail,
                          ),

                          // Campo senha.
                          CampoTexto(
                            // Campo de texto "Senha".
                            labelText: 'Senha',

                            // Icone prefixo.
                            prefixIcon: Icon(Icons.lock),

                            // Oculta o texto.
                            obscureText: true,

                            // Indica qual é o campo.
                            focusNode: _campoSenha,

                            // O botão de enter leva para o próximo campo.
                            textInputAction: TextInputAction.done,

                            // ??
                            onChanged: _loginUsuario.changePassword,

                            // ??
                            stream: _loginUsuario.outPassword,

                            // Ação realizada quando apertar o enter.
                            onFieldSubmitted: (_) =>
                                _loginUsuario.logarUsuario(),
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
                                      value: isMarcado,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isMarcado = value!;
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
                                        fontWeight: FontWeight
                                            .w500, // Largura da fonte.
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
                                          fontWeight: FontWeight
                                              .w500, // Largura da fonte.
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
                    // Texto do botão.
                    labelText: "Entrar",

                    // Ação que o botão realiza ao ser pressionado.
                    onPressed: () => {_loginUsuario.logarUsuario()},
                  ),

                  Botao(
                    labelText: "Entrar como visitante",
                    onPressed: () {},
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TelaCadastroUsuario(),
                            ),
                          );
                        },
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
              );
          }
        },
      ),
    );
  }
}
