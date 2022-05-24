// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/components/custom_text_field.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:provider/provider.dart';

class PopupDialog extends StatefulWidget {
  final String titulo;
  final String? descricao;
  final String yesLabel;
  final String noLabel;
  final bool isPassword;
  final bool isTextField;
  final String? titleTextField;
  final void Function()? onPressedNoOption;
  final void Function()? onPressedYesOption;

  const PopupDialog({
    Key? key,
    required this.titulo,
    this.descricao,
    this.isPassword = false,
    this.isTextField = false,
    this.onPressedNoOption,
    this.onPressedYesOption,
    this.yesLabel = 'Sim',
    this.noLabel = 'Não',
    this.titleTextField,
  }) : super(key: key);

  @override
  State<PopupDialog> createState() => _PopupDialogState();
}

//TODO: Verificar os campos de nome do hambúrguer (montagem do hambúrguer)
// e senha (pra excluir conta na tela de configurações)
class _PopupDialogState extends State<PopupDialog> {
  final _formKey = GlobalKey<FormState>();

  // Campos que estão com foco.
  final _campoSenha = FocusNode();

  final _campoNovaSenha = FocusNode();

  final _campoConfirmarNovaSenha = FocusNode();

  // Campos de texto.
  final _senha = TextEditingController();

  final _novaSenha = TextEditingController();

  final _confirmarNovaSenha = TextEditingController();

  final _nomeDoHamburguer = TextEditingController();

  // Flags
  bool exibirSenha = false;
  bool exibirNovaSenha = false;
  bool exibirConfirmarNovaSenha = false;
  bool _updatedPassword = false;
  bool _loading = false;

  // Libera os recursos após sair da tela ou salvar os dados.
  @override
  void dispose() {
    super.dispose();
    _campoSenha.dispose();
    _campoNovaSenha.dispose();
    _campoConfirmarNovaSenha.dispose();
  }

  Future<void> alterarSenha(BuildContext context) async {
    final pvdUser = Provider.of<ProviderUsuario>(
      context,
      listen: false,
    );
    setState(() => _loading = true);
    final bool updatedPassword = await pvdUser.updatePassword(
      pvdUser.usuario,
      _senha.text,
      _novaSenha.text,
    );

    setState(() {
      _updatedPassword = updatedPassword;
      _loading = false;
    });
  }

  Widget? buildContent(BuildContext context) {
    bool flag = false;
    if (widget.isPassword) {
      return SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            /*
            * Campo senha
            */
            CustomTextField(
              labelText: 'Senha atual',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: GestureDetector(
                child: Icon(
                  exibirSenha ? Icons.visibility : Icons.visibility_off,
                ),
                onTap: () {
                  setState(() {
                    exibirSenha = !exibirSenha;
                  });
                },
              ),
              focusNode: _campoSenha,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_campoNovaSenha);
              },
              textInputAction: TextInputAction.next,
              obscureText: !exibirSenha,
              controller: _senha,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'Campo obrigatório';
                }
                if (!_updatedPassword) {
                  return 'Senha incorreta';
                  //TODO: (Juao: SIM) = Fazer logout para entrar com a nova senha?
                }

                return null;
              },
            ),
            /*
            * Campo nova senha
            */
            CustomTextField(
              labelText: 'Nova senha',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: GestureDetector(
                child: Icon(
                    exibirNovaSenha ? Icons.visibility : Icons.visibility_off),
                onTap: () {
                  setState(() {
                    exibirNovaSenha = !exibirNovaSenha;
                  });
                },
              ),
              focusNode: _campoNovaSenha,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_campoConfirmarNovaSenha);
              },
              obscureText: !exibirNovaSenha,
              controller: _novaSenha,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'Campo obrigatório';
                } else if (value.length < 6) {
                  return 'Mínimo de 6 caracteres';
                } else if (_confirmarNovaSenha.text != _novaSenha.text) {
                  return 'As senhas são diferentes';
                }
                return null;
              },
            ),
            /*
            * Campo confirmar nova senha
            */
            CustomTextField(
              labelText: 'Confirmar nova senha',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: GestureDetector(
                child: Icon(
                    exibirNovaSenha ? Icons.visibility : Icons.visibility_off),
                onTap: () {
                  setState(() {
                    exibirNovaSenha = !exibirNovaSenha;
                  });
                },
              ),
              focusNode: _campoConfirmarNovaSenha,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) async {
                if (_formKey.currentState!.validate()) {
                  await alterarSenha(context);
                  if (_updatedPassword) {
                    Navigator.of(context).pop();
                    //TODO: (Juao: SIM) = Fazer logout para entrar com a nova senha?
                  } else {
                    // TODO: Avisar para o usuário que a senha atual está incorreta
                    print('senha incorreta');
                  }
                }
              },
              obscureText: !exibirNovaSenha,
              controller: _confirmarNovaSenha,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'Campo obrigatório';
                } else if (value.length < 6) {
                  return 'Mínimo de 6 caracteres';
                } else if (_confirmarNovaSenha.text != _novaSenha.text) {
                  return 'As senhas são diferentes';
                }
                return null;
              },
            ),
          ]),
        ),
      );
    } else if (widget.descricao != null) {
      return CustomText(
        widget.descricao!,
        textAlign: TextAlign.center,
      );
    } else if (widget.isTextField && widget.titleTextField == 'Senha') {
      CustomTextField(
        labelText: 'Senha',
        suffixIcon: GestureDetector(
          child:
              Icon(exibirNovaSenha ? Icons.visibility : Icons.visibility_off),
          onTap: () {
            setState(() {
              exibirNovaSenha = !exibirNovaSenha;
            });
          },
        ),
        obscureText: !exibirNovaSenha,
        controller: _novaSenha,
        validator: (value) {
          if (value!.trim().isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      );
    } else if (widget.isTextField &&
        widget.titleTextField == 'Nome do hambúrguer') {
      return CustomTextField(
        labelText: 'Nome do hambúrguer',
        controller: _nomeDoHamburguer,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Insira um nome válido';
          }
        },
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 70),
      // padd
      title: CustomText(
        widget.titulo,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
      content: buildContent(context),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Botao(
                loading: (widget.isPassword) ? _loading : false,
                onPressed: widget.isPassword
                    ? () async {
                        if (_formKey.currentState!.validate()) {
                          await alterarSenha(context);
                          if (_updatedPassword) {
                            Navigator.of(context).pop();
                            //TODO: (Juao: SIM) Fazer logout para entrar com a nova senha?
                          } else {
                            //TODO: Verifiquei se a senha estava correta ali na linha 128, mas a mensagem continua
                          }
                        }
                      }
                    : widget.onPressedYesOption,
                labelText: widget.yesLabel,
                externalPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.15,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: widget.onPressedNoOption,
              child: CustomText(
                widget.noLabel,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
