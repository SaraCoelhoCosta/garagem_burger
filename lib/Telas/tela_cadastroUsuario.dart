// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, sized_box_for_whitespace, avoid_print, prefer_collection_literals, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:garagem_burger/Telas/Componentes/botao.dart';
import 'package:garagem_burger/Telas/Componentes/campo_texto.dart';
import 'package:garagem_burger/Telas/tela_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TelaCadastroUsuario extends StatefulWidget {
  const TelaCadastroUsuario({Key? key}) : super(key: key);

  @override
  _TelaCadastroUsuarioState createState() => _TelaCadastroUsuarioState();
}

class _TelaCadastroUsuarioState extends State<TelaCadastroUsuario> {
  // Campos que estão com foco.
  final _campoEmail = FocusNode();
  final _campoTelefone = FocusNode();
  final _campoDataNascimento = FocusNode();
  final _campoCPF = FocusNode();
  final _campoSenha = FocusNode();
  final _campoConfirmarSenha = FocusNode();

  // Chave global que vai fazer referência ao formulário.
  final _chaveFormulario = GlobalKey<FormState>();

  // Vai pegar os dados de cada campo do formulário.
  final _dadosFormulario = Map<String, Object>();

  // Expressão regular.
  final regex = RegExp(r'^[a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$');

  // Máscara para telefone.
  var mascaraTelefone = new MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

// Máscara para data de nascimento.
  var mascaraDataNascimento = new MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

// Máscara para cpf.
  var mascaraCpf = new MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  // Libera os recursos após sair da tela ou slavar os dados.
  @override
  void dispose() {
    super.dispose();
    _campoEmail.dispose();
    _campoTelefone.dispose();
    _campoDataNascimento.dispose();
    _campoCPF.dispose();
    _campoSenha.dispose();
    _campoConfirmarSenha.dispose();
  }

  /* A partir da chave ele vai identificar o formulário e pega os dados de cada 
   * campo com ajuda do onSaved: () => {}.
   * A função abaixo vai salvar os dados no Banco de dados.
   */
  void _salvarCadastro() {
    final isValido = _chaveFormulario.currentState?.validate() ?? false;
    if (!isValido) {
      return;
    }

    _chaveFormulario.currentState?.save();
    print(_dadosFormulario.values);
    /*

    final novoUsuario = Usuario(
      id: Random().nextDouble().toString(),
      nome: _formData['nome'] as String,
      email: _formData['email'] as String,
      telefone: _formData['telefone'] as String,
      dataNascimento: _formData['dataNascimento'] as String,
      cpf: _formData['cpf'] as String,
      senha: _formData['senha'] as String,
      confirmarSenha: _formData['confirmarSenha'] as String,
    );*/
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
              key: _chaveFormulario,
              child: Column(
                children: [
                  // Campo de nome.
                  CampoTexto(
                    // Nome do campo.
                    labelText: 'Nome',

                    // Icone perfixo.
                    prefixIcon: Icon(Icons.person),
                    suffixIconButton: null,
                    obscureText: false,
                    // Define o tipo de entrada do campo.
                    keyboardType: TextInputType.name,

                    // Aponta para o próximo campo de entrada.
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_campoEmail);
                    },

                    // Pega informação do campo para realizar o cadastro.
                    onSaved: (nome) => {
                      _dadosFormulario['nome'] = nome ?? '',
                    },

                    // O botão de enter leva para o próximo campo.
                    textInputAction: TextInputAction.next,
                    // Validação do campo.
                    validator: (_nome) {
                      final nome = _nome ?? '';

                      if (nome.trim().isEmpty) {
                        return 'Nome é obrigatório.';
                      }

                      if (!regex.hasMatch(nome)) {
                        return "Nome inválido!";
                      }

                      return null;
                    },

                    focusNode: null,
                    inputFormatters: null,
                  ),

                  // Campo de e-mail.
                  CampoTexto(
                    // Campo de texto "E-mail".

                    labelText: 'E-mail',
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

                    // Pega informação do campo para realizar o cadastro.
                    onSaved: (email) => {
                      _dadosFormulario['email'] = email ?? '',
                    },

                    // Validação do campo.
                    validator: (_email) {
                      final email = _email ?? '';

                      if (email.trim().isEmpty) {
                        return 'E-mail é obrigatório.';
                      }

                      if (email.length < 6 ||
                          !email.contains("@") ||
                          !email.endsWith(".com")) {
                        return "E-mail inválido!";
                      }

                      return null;
                    },
                    obscureText: false,
                  ),

                  // Campo de telefone.
                  CampoTexto(
                    // Campo de texto "Telefone".

                    labelText: 'Telefone',
                    prefixIcon: Icon(Icons.phone),

                    // Define o tipo de entrada do campo.
                    keyboardType: TextInputType.number,

                    // Máscara do telefone.
                    inputFormatters: [mascaraTelefone],

                    // Indica qual é o campo.
                    focusNode: _campoTelefone,

                    // Aponta para o próximo campo de entrada.
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_campoDataNascimento);
                    },

                    // O botão de enter leva para o próximo campo.
                    textInputAction: TextInputAction.next,

                    // Pega informação do campo para realizar o cadastro.
                    onSaved: (telefone) =>
                        {_dadosFormulario['telefone'] = telefone ?? ''},

                    // Validação do campo.
                    validator: (_telefone) {
                      final telefone = _telefone ?? '';

                      if (telefone.trim().isEmpty) {
                        return 'Telefone é obrigatório.';
                      }

                      return null;
                    },
                    obscureText: false,
                  ),

                  CampoTexto(
                    // Campo de texto "Senha".

                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock),
                    // Icone com ação. - suffixIcon: IconButton(onPressed: () => {}, icon: Icon(Icons.remove_red_eye),),

                    // Indica qual é o campo.
                    focusNode: _campoSenha,

                    // Aponta para o próximo campo de entrada.
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_campoConfirmarSenha);
                    },

                    // O botão de enter leva para o próximo campo.
                    textInputAction: TextInputAction.next,

                    // Pega informação do campo para realizar o cadastro.
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
                    keyboardType: null,
                    obscureText: true,
                  ),

                  // Campo de confirmar senha.
                  CampoTexto(
                    // Campo de texto "Confirmar Senha".

                    labelText: 'Confirmar Senha',
                    prefixIcon: Icon(Icons.lock),
                    // Indica qual é o campo.
                    focusNode: _campoConfirmarSenha,

                    // O botão de enter realiza cadastro.
                    textInputAction: TextInputAction.done,
                    // Pega informação do campo para realizar o cadastro.
                    onSaved: (confirmarSenha) => {
                      _dadosFormulario['confirmarSenha'] = confirmarSenha ?? ''
                    },

                    // Chama a função para concluir cadastro.
                    onFieldSubmitted: (_) => _salvarCadastro(),

                    // Validação do campo.
                    validator: (_confirmarSenha) {
                      final confirmarSenha = _confirmarSenha ?? '';

                      if (confirmarSenha.trim().isEmpty) {
                        return 'Confirmar Senha é obrigatório.';
                      }

                      return null;
                    },
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),

          Botao(
            labelText: "Cadastrar",
            // Ação que o botão realiza ao ser pressionado.
            onPressed: () => {_salvarCadastro()},
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaLogin(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
