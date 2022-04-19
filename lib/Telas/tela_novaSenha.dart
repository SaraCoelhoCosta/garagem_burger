// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:garagem_burger/Telas/Componentes/botao.dart';
import 'package:garagem_burger/Telas/Componentes/campo_texto.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaNovaSenha extends StatefulWidget {
  const TelaNovaSenha({Key? key}) : super(key: key);

  @override
  _TelaNovaSenhaState createState() => _TelaNovaSenhaState();
}

class _TelaNovaSenhaState extends State<TelaNovaSenha> {
  // Campos que estão com foco.
  final _campoConfirmarSenha = FocusNode();

  // Chave global que vai fazer referência ao formulário.
  final _chaveFormulario = GlobalKey<FormState>();

  // Vai pegar os dados de cada campo do formulário.
  final _dadosFormulario = Map<String, Object>();

  // Libera os recursos após sair da tela ou slavar os dados.
  @override
  void dispose() {
    super.dispose();
    _campoConfirmarSenha.dispose();
  }

  /* A partir da chave ele vai identificar o formulário e pega os dados de cada 
   * campo com ajuda do onSaved: () => {}.
   * A função abaixo vai alterar senha.
   */
  void _alterarSenha() {
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

          Container(
            // Largura e altura.
            width: 175,
            height: 175,

            // Imagem.
            child: Image.asset(
              "./images/logoHamburgueria.png",
            ),
          ),

          // Espaçamento vertical entre Imagem e texto.
          SizedBox(height: tamanho.height * 0.025),

          Center(
            child: Text(
              "Digite a nova senha:",

              // Estilo do texto com fonte do google.
              style: GoogleFonts.oxygen(
                fontSize: 24, // Tamanho da fonte.
                fontWeight: FontWeight.bold, // Largura da fonte.
              ),
            ),
          ),

          // Espaçamento vertical entre o texto e o formulário.
          SizedBox(height: tamanho.height * 0.03),

          Padding(
            padding: const EdgeInsets.all(10.0),
            // Formulário.
            child: Form(
              key: _chaveFormulario,
              child: Column(
                children: [
                  // Campo senha.
                  CampoTexto(
                    // Campo de texto "Senha".

                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock),

                    // Oculta o texto.
                    obscureText: true,

                    // Aponta para o próximo campo de entrada.
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_campoConfirmarSenha);
                    },

                    // O botão de enter leva para o próximo campo.
                    textInputAction: TextInputAction.next,

                    // Pega informação do campo para realizar alteração da senha.
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
                  ),

                  // Campo confirmar senha.
                  CampoTexto(
                    // Campo de texto "Confirmar Senha".

                    labelText: 'Confirmar Senha',
                    prefixIcon: Icon(Icons.lock),

                    // Oculta o texto.
                    obscureText: true,

                    // Indica qual é o campo.
                    focusNode: _campoConfirmarSenha,

                    // O botão de enter realiza cadastro.
                    textInputAction: TextInputAction.done,

                    // Pega informação do campo para realizar alteração da senha.
                    onSaved: (confirmarSenha) => {
                      _dadosFormulario['confirmarSenha'] = confirmarSenha ?? ''
                    },

                    // Validação do campo.
                    validator: (_confirmarSenha) {
                      final confirmarSenha = _confirmarSenha ?? '';

                      if (confirmarSenha.trim().isEmpty) {
                        return 'Confirmar Senha é obrigatória.';
                      }

                      return null;
                    },

                    onFieldSubmitted: (_) => _alterarSenha(),
                  ),
                ],
              ),
            ),
          ),

          // Espaçamento vertical entre formulário e botão.
          SizedBox(height: tamanho.height * 0.05),

          Botao(
            labelText: "Confirmar",
            // Ação que o botão realiza ao ser pressionado.
            onPressed: () => {_alterarSenha()},
          ),
        ],
      ),
    );
  }
}
