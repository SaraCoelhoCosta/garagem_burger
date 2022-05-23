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
  final void Function()? onPressedNoOption;
  final void Function()? onPressedYesOption;

  const PopupDialog({
    Key? key,
    required this.titulo,
    this.descricao,
    this.isPassword = false,
    this.onPressedNoOption,
    this.onPressedYesOption,
    this.yesLabel = 'Sim',
    this.noLabel = 'Não',
  }) : super(key: key);

  @override
  State<PopupDialog> createState() => _PopupDialogState();
}

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

  // Flags
  bool exibirSenha = false;

  bool exibirNovaSenha = false;

  bool exibirConfirmarNovaSenha = false;

  bool _loading = false;

  Map<String, dynamic>? senhas;

  // Libera os recursos após sair da tela ou salvar os dados.
  @override
  void dispose() {
    super.dispose();
    _campoSenha.dispose();
    _campoNovaSenha.dispose();
    _campoConfirmarNovaSenha.dispose();
  }

  Future<bool> alterarSenha(BuildContext context) async {
    final pvdUser = Provider.of<ProviderUsuario>(
      context,
      listen: false,
    );
    return await pvdUser.verifyPassword(
      pvdUser.usuario,
      senhas!['senhaAtual'],
    );

    // if (!isEqual) {
    //   print('Senha incorreta!');
    // } else {
    //   print('senha alterada');
    //   Navigator.of(context).pop;
    // }
  }

  Widget? buildContent(BuildContext context) {
    final pvdUser = Provider.of<ProviderUsuario>(
      context,
      listen: false,
    );
    if (widget.isPassword) {
      return Form(
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
              FocusScope.of(context).requestFocus(_campoNovaSenha);
            },
            obscureText: !exibirNovaSenha,
            controller: _novaSenha,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Campo obrigatório';
              } else if (value.length < 6) {
                return 'Sua senha deve ter no mínimo 6 caracteres';
              } else if (_confirmarNovaSenha.text != _novaSenha.text) {
                return 'As senhas são diferentes';
              }
              return null;
            },
          ),
          /*
          * Campo nova senha
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
                senhas = {
                  'senhaAtual': _senha.text,
                  'novaSenha': _novaSenha.text,
                  'confirmarNovaSenha': _confirmarNovaSenha.text,
                };
                await alterarSenha(context);
              }
            },
            obscureText: !exibirNovaSenha,
            controller: _confirmarNovaSenha,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Campo obrigatório';
              } else if (value.length < 6) {
                return 'Sua senha deve ter no mínimo 6 caracteres';
              } else if (_confirmarNovaSenha.text != _novaSenha.text) {
                return 'As senhas são diferentes';
              }
              return null;
            },
          ),
        ]),
      );
    } else if (widget.descricao != null) {
      return CustomText(
        widget.descricao!,
        textAlign: TextAlign.center,
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
                onPressed: widget.isPassword
                    ? () async {
                        if (_formKey.currentState!.validate()) {
                          senhas = {
                            'senhaAtual': _senha.text,
                            'novaSenha': _novaSenha.text,
                            'confirmarNovaSenha': _confirmarNovaSenha.text,
                          };
                          if (await alterarSenha(context)) {
                            Navigator.of(context).pop;
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
