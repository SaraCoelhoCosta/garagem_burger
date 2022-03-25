// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:garagem_burger/Telas/tela_cadastroUsuario.dart';
import 'package:garagem_burger/Telas/tela_esqueceuSenha.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  // Campos que estão com foco.
  final _campoSenha = FocusNode();

  // Chave global que vai fazer referência ao formulário.
  final _chaveFormulario = GlobalKey<FormState>();

  // Vai pegar os dados de cada campo do formulário.
  final _dadosFormulario = Map<String, Object>();

  // Flag para checkbox.
  bool isMarcado = false;

  // Libera os recursos após sair da tela ou slavar os dados.
  @override
  void dispose() {
    super.dispose();
    _campoSenha.dispose();
  }

  /* A partir da chave ele vai identificar o formulário e pega os dados de cada 
   * campo com ajuda do onSaved: () => {}.
   * A função abaixo vai realizar o login.
   */
  void _fazerLogin() {
    final isValido = _chaveFormulario.currentState?.validate() ?? false;
    if (!isValido) {
      return;
    }

    _chaveFormulario.currentState?.save();
    print(_dadosFormulario.values);
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
              key: _chaveFormulario,
              child: Column(
                children: [
                  // Campo e-mail.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      // Campo de texto "E-mail".
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        prefixIcon: Icon(Icons.email),
                      ),

                      // Define o tipo de entrada do campo.
                      keyboardType: TextInputType.emailAddress,

                      // Aponta para o próximo campo de entrada.
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_campoSenha);
                      },

                      // O botão de enter leva para o próximo campo.
                      textInputAction: TextInputAction.next,

                      // Pega informação do campo para realizar o login.
                      onSaved: (email) => {
                        _dadosFormulario['email'] = email ?? '',
                      },

                      // Validação do campo.
                      validator: (_email) {
                        final email = _email ?? '';

                        if (email.trim().isEmpty) {
                          return 'E-mail é obrigatório.';
                        }

                        return null;
                      },
                    ),
                  ),

                  // Campo senha.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      // Campo de texto "Senha".
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: Icon(Icons.lock),
                      ),

                      // Oculta o texto.
                      obscureText: true,

                      // Indica qual é o campo.
                      focusNode: _campoSenha,

                      // O botão de enter leva para o próximo campo.
                      textInputAction: TextInputAction.done,

                      // Pega informação do campo para realizar login.
                      onSaved: (senha) =>
                          {_dadosFormulario['senha'] = senha ?? ''},

                      // Validação do campo.
                      validator: (_senha) {
                        final senha = _senha ?? '';

                        if (senha.trim().isEmpty) {
                          return 'Senha é obrigatória.';
                        }

                        return null;
                      },

                      onFieldSubmitted: (_) => _fazerLogin(),
                    ),
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TelaEsqueceuSenha(),
                                  ),
                                );
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            // Botão.
            child: ElevatedButton(
              // Texto do botão.
              child: Text(
                "Entrar",
              ),

              // Estilo do botão.
              style: ElevatedButton.styleFrom(
                primary: Colors.black,

                // Arredonda as bordas do botão.
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),

                // Aumenta a altura do botão (?)
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                ),

                // Estilo do texto do botão.
                // Fonte do Google.
                textStyle: GoogleFonts.oxygen(
                  fontSize: 18, // Tamanho da fonte.
                  fontWeight: FontWeight.bold, // Largura da fonte.
                  color: Colors.white, // Cor da fonte.
                ),
              ),

              // Ação que o botão realiza ao ser pressionado.
              onPressed: () => {_fazerLogin()},
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            // Botão.
            child: ElevatedButton(
              // Texto do botão.
              child: Text(
                "Entrar como visitante",
              ),

              // Estilo do botão.
              style: ElevatedButton.styleFrom(
                primary: Colors.black,

                // Arredonda as bordas do botão.
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),

                // Aumenta a altura do botão (?)
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                ),

                // Estilo do texto do botão.
                // Fonte do Google.
                textStyle: GoogleFonts.oxygen(
                  fontSize: 18, // Tamanho da fonte.
                  fontWeight: FontWeight.bold, // Largura da fonte.
                  color: Colors.white, // Cor da fonte.
                ),
              ),

              // Ação que o botão realiza ao ser pressionado.
              onPressed: () => {},
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
                onPressed: () {
                  Navigator.pushReplacement(
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
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 40,
                      width: 40,
                      // Imagem.
                      child: Image.asset(
                        "./images/google.png",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      width: 40,
                      // Imagem.
                      child: Image.asset(
                        "./images/facebook.png",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      width: 40,
                      // Imagem.
                      child: Image.asset(
                        "./images/twitter.png",
                      ),
                    ),
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
