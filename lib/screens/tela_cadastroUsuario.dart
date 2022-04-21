// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, sized_box_for_whitespace, avoid_print, prefer_collection_literals, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:garagem_burger/controllers/novo_usuario.dart';
import 'package:garagem_burger/screens/components/botao.dart';
import 'package:garagem_burger/screens/components/campo_texto.dart';
import 'package:garagem_burger/screens/tela_login.dart';
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

  // Máscara para telefone.
  var mascaraTelefone = new MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  // Controle para cadastro.
  final _novoUsuario = NovoUsuario();

  // Flag para senha.
  bool exibirSenha = false;

  // Libera os recursos após sair da tela ou salvar os dados.
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

  @override
  Widget build(BuildContext context) {
    // Pega tamanho da tela.
    Size tamanho = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xfffed80b), // Cor de fundo.

      body: StreamBuilder<EstadoNovoUsuario>(
        stream: _novoUsuario.outState,
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case EstadoNovoUsuario.CARREGANDO:
              return Center(
                child: CircularProgressIndicator(),
              );
            case EstadoNovoUsuario.SUCESSO:
            case EstadoNovoUsuario.FALHA:
            case EstadoNovoUsuario.PARADO:
            default:
              return ListView(
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
                      child: Column(
                        children: [
                          // Campo de nome.
                          CampoTexto(
                            // Nome do campo.
                            labelText: 'Nome',

                            // Icone perfixo.
                            prefixIcon: Icon(Icons.person),

                            // Botão em forma de ícone sufixo.
                            suffixIconButton: null,

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

                            // ??
                            onChanged: _novoUsuario.changeName,

                            // ??
                            stream: _novoUsuario.outName,
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
                              FocusScope.of(context)
                                  .requestFocus(_campoTelefone);
                            },

                            // O botão de enter leva para o próximo campo.
                            textInputAction: TextInputAction.next,

                            // Oculta o texto.
                            obscureText: false,

                            // ??
                            onChanged: _novoUsuario.changeEmail,

                            // ??
                            stream: _novoUsuario.outEmail,
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
                              FocusScope.of(context)
                                  .requestFocus(_campoDataNascimento);
                            },

                            // O botão de enter leva para o próximo campo.
                            textInputAction: TextInputAction.next,

                            // Oculta o texto.
                            obscureText: false,

                            // ??
                            onChanged: _novoUsuario.changePhone,

                            // ??
                            stream: _novoUsuario.outPhone,
                          ),

                          CampoTexto(
                            // Campo de texto "Senha".
                            labelText: 'Senha',

                            // Icone prefixo.
                            prefixIcon: Icon(Icons.lock),
                            // Icone com ação. - suffixIcon: IconButton(onPressed: () => {}, icon: Icon(Icons.remove_red_eye),),

                            // Icone sufixo (exibir senha)
                            suffixIcon: GestureDetector(
                              child: Icon(exibirSenha ? Icons.visibility : Icons.visibility_off),
                              onTap: (){
                                setState(() {
                                  exibirSenha = !exibirSenha;
                                });
                              },
                            ),
                            // Indica qual é o campo.
                            focusNode: _campoSenha,

                            // Aponta para o próximo campo de entrada.
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_campoConfirmarSenha);
                            },

                            // O botão de enter leva para o próximo campo.
                            textInputAction: TextInputAction.next,

                            // Oculta texto.
                            obscureText: !exibirSenha,

                            // ??
                            onChanged: _novoUsuario.changePassword,

                            // ??
                            stream: _novoUsuario.outPassword,
                          ),

                          // Campo de confirmar senha.
                          CampoTexto(
                            // Campo de texto "Confirmar Senha".
                            labelText: 'Confirmar Senha',

                            // Icone prefixo.
                            prefixIcon: Icon(Icons.lock),

                            // Icone sufixo (exibir senha)
                            suffixIcon: GestureDetector(
                              child: Icon(exibirSenha ? Icons.visibility : Icons.visibility_off),
                              onTap: (){
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
                            onFieldSubmitted: (_) =>
                                _novoUsuario.cadastrarUsuario(),

                            // Oculta texto.
                            obscureText: !exibirSenha,

                            // ??
                            onChanged: _novoUsuario.changeConfirmPassword,

                            // ??
                            stream: _novoUsuario.outConfirmPassword,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Botao(
                    labelText: "Cadastrar",
                    // Ação que o botão realiza ao ser pressionado.
                    onPressed: () => {_novoUsuario.cadastrarUsuario()},
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
              );
          }
        },
      ),
    );
  }
}
