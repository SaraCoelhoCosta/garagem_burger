// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:garagem_burger/Telas/tela_login.dart';
import 'package:garagem_burger/Telas/tela_novaSenha.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaEsqueceuSenha extends StatefulWidget {
  const TelaEsqueceuSenha({Key? key}) : super(key: key);

  @override
  _TelaEsqueceuSenhaState createState() => _TelaEsqueceuSenhaState();
}

class _TelaEsqueceuSenhaState extends State<TelaEsqueceuSenha> {
  // Chave global que vai fazer referência ao formulário.
  final _chaveFormulario = GlobalKey<FormState>();

  // Vai pegar os dados de cada campo do formulário.
  String? _dadosFormulario;

  /* A partir da chave ele vai identificar o formulário e pega os dados de cada 
   * campo com ajuda do onSaved: () => {}.
   * A função abaixo vai enviar email para o cliente.
   */
  void _enviarEmail() {
    final isValido = _chaveFormulario.currentState?.validate() ?? false;
    if (!isValido) {
      return;
    }

    _chaveFormulario.currentState?.save();
    print(_dadosFormulario);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TelaNovaSenha(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pega tamanho da tela.
    Size tamanho = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xfffed80b), // Cor de fundo.

      body: ListView(
        children: [
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

          // Texto.
          Center(
            child: Text(
              "Digite o e-mail cadastrado:",

              // Estilo do texto com fongtes do google.
              style: GoogleFonts.oxygen(
                fontSize: 24, // Tamanho da fonte.
                fontWeight: FontWeight.bold, // Largura da fonte.
              ),
            ),
          ),

          // Espaçamento vertical entre texto e formulário.
          SizedBox(height: tamanho.height * 0.03),

          Padding(
            padding: const EdgeInsets.all(10.0),

            // Formulário.
            child: Form(
              key: _chaveFormulario,
              child:
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

                  // Pega informação do campo para realizar o login.
                  onSaved: (email) => {
                    _dadosFormulario = email ?? '',
                  },

                  // Validação do campo.
                  validator: (_email) {
                    final email = _email ?? '';

                    if (email.trim().isEmpty) {
                      return 'E-mail é obrigatório.';
                    }

                    return null;
                  },

                  // O botão de enter leva para o próximo campo.
                  textInputAction: TextInputAction.done,

                  onFieldSubmitted: (_) => _enviarEmail(),
                ),
              ),
            ),
          ),

          // Espaçamento vertical entre formulário e botões.
          SizedBox(height: tamanho.height * 0.05),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            // Botão.
            child: ElevatedButton(
              // Texto do botão.
              child: Text(
                "Confirmar",
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
              onPressed: () => {
                _enviarEmail(),
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            // Botão.
            child: ElevatedButton(
              // Texto do botão.
              child: Text(
                "Voltar",
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
              onPressed: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaLogin(),
                  ),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
