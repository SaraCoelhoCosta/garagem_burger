// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:garagem_burger/components/campo_texto.dart';
import 'package:provider/provider.dart';

class TelaEsqueceuSenha extends StatefulWidget {
  const TelaEsqueceuSenha({Key? key}) : super(key: key);

  @override
  _TelaEsqueceuSenhaState createState() => _TelaEsqueceuSenhaState();
}

class _TelaEsqueceuSenhaState extends State<TelaEsqueceuSenha> {
// Chave do formulário.
  final _formKey = GlobalKey<FormState>();

  // Mostrar estado durante a realização do login.
  bool _loading = false;

  // Campos de texto.
  final _email = TextEditingController();

  recuperarSenha() async {
    setState(() => _loading = true);
    try {
      final pvdUsuario = context.read<ProviderUsuario>();
      await pvdUsuario.recuperarSenha(_email.text);

      // TODO: Colocar um pop-up.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Link enviado por e-mail"),
        backgroundColor: Colors.green,
      ));

      // Navega para a tela de menu
      Navigator.of(context).pushReplacementNamed(
        Rotas.login,
      );
    } on AuthException catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pega tamanho da tela.
    Size tamanho = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: [
          // Espaçamento vertical início da tela e imagem.
          SizedBox(height: tamanho.height * 0.04),

          // Imagem
          Hero(
            tag: 'logo',
            child: SizedBox(
              width: 175,
              height: 175,
              child: Image.asset("./images/logoHamburgueria.png"),
            ),
          ),

          // Espaçamento vertical entre a imagem e o formulário.
          SizedBox(height: tamanho.height * 0.03),
          Text("Insira seu e-mail", textAlign: TextAlign.center),
          SizedBox(height: tamanho.height * 0.02),
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

                    // Aponta para o próximo campo de entrada.
                    onFieldSubmitted: (_) => {
                      if (_formKey.currentState!.validate())
                        {
                          recuperarSenha(),
                        },
                    },

                    // O botão de enter leva para o próximo campo.
                    textInputAction: TextInputAction.done,

                    // Validação do campo.
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Campo obrigatório';
                      } else if (!value.contains('@') ||
                          value.trim().length < 10) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },

                    controller: _email,
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
            loading: _loading,
            labelText: "Confirmar",
            onPressed: () => {
              _formKey.currentState!.validate() ? recuperarSenha() : null,
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
            labelText: "Voltar",
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
