import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/controllers/provider_cartoes.dart';
import 'package:garagem_burger/controllers/provider_localizacoes.dart';
import 'package:garagem_burger/controllers/provider_pedidos.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:garagem_burger/components/custom_text_field.dart';
import 'package:garagem_burger/pages/menu/tela_menu.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';

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

  Future<void> loadUserData() async {
    final pvdUsuario = context.read<ProviderUsuario>();

    // Carrega as localizações do usuário
    await context
        .read<ProviderLocalizacoes>()
        .loadLocations(pvdUsuario.usuario);

    // Carrega os cartões do usuário
    await context.read<ProviderCartoes>().loadCartoes(pvdUsuario.usuario);

    // Carrega os pedidos do usuário
    await context.read<ProviderPedidos>().loadPedidos(pvdUsuario.usuario);
  }

  efetuarLoginGoogle() async {
    // TODO: Arrumar login (Não cadastrta usuário).
    try {
      final pvdUsuario = context.read<ProviderUsuario>();
      await pvdUsuario.signInWithGoogle();

      // Carrega os dados do usuario
      //await loadUserData();

      // Navega para a tela de menu
      Navigator.of(context).pushReplacementNamed(
        Rotas.main,
        arguments: {
          'index': 0,
          'page': const TelaMenu(),
          'button': null,
        },
      );
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomText(e.message),
        backgroundColor: Colors.red,
      ));
    }
  }

  efetuarLoginFacebook() async {
    try {
      // TODO: Arrumar login (Não cadastrta usuário).
      final pvdUsuario = context.read<ProviderUsuario>();
      await pvdUsuario.signInWithFacebook();

      // Carrega os dados do usuario
      //await loadUserData();

      // Navega para a tela de menu
      Navigator.of(context).pushReplacementNamed(
        Rotas.main,
        arguments: {
          'index': 0,
          'page': const TelaMenu(),
          'button': null,
        },
      );
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomText(e.message),
        backgroundColor: Colors.red,
      ));
    }
  }

  efetuarLogin() async {
    setState(() => _loading = true);
    try {
      final pvdUsuario = context.read<ProviderUsuario>();
      await pvdUsuario.login(_email.text, _senha.text, _isMarcado);

      // Carrega os dados do usuario
      await loadUserData();

      // Navega para a tela de menu
      Navigator.of(context).pushReplacementNamed(
        Rotas.main,
        arguments: {
          'index': 0,
          'page': const TelaMenu(),
          'button': null,
        },
      );
    } on AuthException catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomText(e.message),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pega tamanho da tela.
    Size tamanho = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xfffed80b), // Cor de fundo.
      body: ListView(
        children: <Widget>[
          SizedBox(height: tamanho.height * 0.04),
          Hero(
            tag: 'logo',
            child: SizedBox(
              width: 175,
              height: 175,
              child: Image.asset('./images/logoHamburgueria.png'),
            ),
          ),
          SizedBox(height: tamanho.height * 0.03),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: 'E-mail',
                    prefixIcon: const Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_campoSenha);
                    },
                    textInputAction: TextInputAction.next,
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
                  CustomTextField(
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock),
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
                    obscureText: !_exibirSenha,
                    focusNode: _campoSenha,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Campo obrigatório';
                      } else if (value.trim().length < 6) {
                        return 'Sua senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                    controller: _senha,
                    onFieldSubmitted: (_) => {
                      if (_formKey.currentState!.validate())
                        {
                          efetuarLogin(),
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
                            const CustomText(
                              'Mantenha-me conectado',
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent),
                              child: const CustomText(
                                'Esqueci minha senha',
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  Rotas.esqueceuSenha,
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
          Botao(
            internalPadding: const EdgeInsets.symmetric(vertical: 15),
            externalPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            loading: _loading,
            labelText: 'Entrar',
            onPressed: () => {
              _formKey.currentState!.validate() ? efetuarLogin() : null,
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
            labelText: 'Entrar como visitante',
            onPressed: () => Navigator.of(context).pushReplacementNamed(
              Rotas.main,
              arguments: {
                'index': 0,
                'page': const TelaMenu(),
                'button': null,
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                'Não tem conta?',
                fontWeight: FontWeight.w500,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                child: const CustomText(
                  'Cadastre-se',
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Rotas.cadastro);
                },
              ),
            ],
          ),
          SizedBox(height: tamanho.height * 0.05),
          Column(
            children: [
              const Center(
                child: CustomText(
                  'Outras formas de login',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: tamanho.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SignInButton.mini(
                    buttonType: ButtonType.google,
                    onPressed: () => {
                      efetuarLoginGoogle(),
                    },
                  ),
                  SignInButton.mini(
                    buttonType: ButtonType.facebook,
                    onPressed: () => {
                      efetuarLoginFacebook(),
                    },
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
