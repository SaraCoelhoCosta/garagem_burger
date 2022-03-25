// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, sized_box_for_whitespace, avoid_print, prefer_collection_literals, override_on_non_overriding_member

import 'package:flutter/material.dart';
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      // Campo de texto "Nome".
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        prefixIcon: Icon(Icons.person),
                      ),

                      // Define o tipo de entrada do campo.
                      keyboardType: TextInputType.name,

                      // Aponta para o próximo campo de entrada.
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_campoEmail);
                      },

                      // O botão de enter leva para o próximo campo.
                      textInputAction: TextInputAction.next,

                      // Pega informação do campo para realizar o cadastro.
                      onSaved: (nome) => {
                        _dadosFormulario['nome'] = nome ?? '',
                      },

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
                    ),
                  ),

                  // Campo de e-mail.
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
                    ),
                  ),

                  // Campo de telefone.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      // Campo de texto "Telefone".
                      decoration: InputDecoration(
                        labelText: 'Telefone',
                        prefixIcon: Icon(Icons.phone),
                      ),

                      // Define o tipo de entrada do campo.
                      keyboardType: TextInputType.number,

                      // Máscara do telefone.
                      inputFormatters: [mascaraTelefone],

                      // Indica qual é o campo.
                      focusNode: _campoTelefone,

                      // Aponta para o próximo campo de entrada.
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_campoDataNascimento);
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
                    ),
                  ),

                  // Campo de data de nascimento e cpf.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: TextFormField(
                            // Campo de texto "Data de Nascimento".
                            decoration: InputDecoration(
                              labelText: 'Data de Nascimento',
                              prefixIcon: Icon(Icons.date_range),
                            ),

                            // Define o tipo de entrada do campo.
                            keyboardType: TextInputType.number,

                            // Máscara da data de nascimento.
                            inputFormatters: [mascaraDataNascimento],

                            // Indica qual é o campo.
                            focusNode: _campoDataNascimento,

                            // Aponta para o próximo campo de entrada.
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_campoCPF);
                            },

                            // O botão de enter leva para o próximo campo.
                            textInputAction: TextInputAction.next,

                            // Pega informação do campo para realizar o cadastro.
                            onSaved: (dataNascimento) => {
                              _dadosFormulario['dataNascimento'] =
                                  dataNascimento ?? ''
                            },
                          ),
                        ),

                        // Espaçamento horizontal entre dois campos de texto.
                        SizedBox(width: tamanho.width * 0.05),

                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            // Campo de texto "CPF".
                            decoration: InputDecoration(
                              labelText: 'CPF',
                              //prefixIcon: Icon(Icons.document_scanner),
                            ),

                            // Define o tipo de entrada do campo.
                            keyboardType: TextInputType.number,

                            // Máscara do CPF.
                            inputFormatters: [mascaraCpf],

                            // Indica qual é o campo.
                            focusNode: _campoCPF,

                            // Aponta para o próximo campo de entrada.
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_campoSenha);
                            },

                            // O botão de enter leva para o próximo campo.
                            textInputAction: TextInputAction.next,

                            // Pega informação do campo para realizar o cadastro.
                            onSaved: (cpf) =>
                                {_dadosFormulario['cpf'] = cpf ?? ''},
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Campo de senha.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      // Campo de texto "Senha".
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: Icon(Icons.lock),
                        // Icone com ação. - suffixIcon: IconButton(onPressed: () => {}, icon: Icon(Icons.remove_red_eye),),
                      ),

                      // Oculta o texto.
                      obscureText: true,

                      // Indica qual é o campo.
                      focusNode: _campoSenha,

                      // Aponta para o próximo campo de entrada.
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_campoConfirmarSenha);
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
                    ),
                  ),

                  // Campo de confirmar senha.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      // Campo de texto "Confirmar Senha".
                      decoration: InputDecoration(
                        labelText: 'Confirmar Senha',
                        prefixIcon: Icon(Icons.lock),
                      ),

                      // Oculta o texto.
                      obscureText: true,

                      // Indica qual é o campo.
                      focusNode: _campoConfirmarSenha,

                      // O botão de enter realiza cadastro.
                      textInputAction: TextInputAction.done,
                      // Pega informação do campo para realizar o cadastro.
                      onSaved: (confirmarSenha) => {
                        _dadosFormulario['confirmarSenha'] =
                            confirmarSenha ?? ''
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
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            // Botão.
            child: ElevatedButton(
              // Texto do botão.
              child: Text(
                "Cadastrar",
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
              onPressed: () => {_salvarCadastro()},
            ),
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
