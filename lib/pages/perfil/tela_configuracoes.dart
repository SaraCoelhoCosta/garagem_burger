// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/campo_texto.dart';
import 'package:garagem_burger/components/popup_dialog.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Configurações';

  @override
  State<TelaConfiguracoes> createState() => TelaConfiguracoesState();
}

class TelaConfiguracoesState extends State<TelaConfiguracoes> {
  void editarFoto() {
    // ignore: avoid_print
    print("editar foto");
  }

  final _campoNome = FocusNode();
  final _campoDataNascimento = FocusNode();
  final _campoEmail = FocusNode();
  final _campoTelefone = FocusNode();

  // Máscara para telefone.
  var mascaraTelefone = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  var mascaraDataNascimento = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: <String, RegExp>{'#': RegExp('[0-9]')},
  );

  //Libera os recursos após sair da tela ou salvar os dados
  @override
  void dispose() {
    super.dispose();
    _campoNome.dispose();
    _campoDataNascimento.dispose();
    _campoEmail.dispose();
    _campoTelefone.dispose();
  }

  // Campos de texto.
  final _nome = TextEditingController();
  final _dataNascimento = TextEditingController();
  final _email = TextEditingController();
  final _telefone = TextEditingController();

  ImagePicker imagepicker = ImagePicker();
  File? imagemSelecionada;

  @override
  Widget build(BuildContext context) {
    pegarImagemGaleria() async {
      final XFile? imagemTemporaria =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);
      if (imagemTemporaria != null) {
        setState(() {
          imagemSelecionada = File(imagemTemporaria!.path);
        });
      }
    }

    final pvdUsuario = Provider.of<ProviderUsuario>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*
            * Foto e nome
            */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*
                * Foto
                */
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    overflow: Overflow.visible,
                    children: [
                      // const CircleAvatar(
                      //   backgroundColor: Colors.grey,
                      //   // backgroundImage: AssetImage("images/profile.png"),
                      // ),
                      imagemSelecionada == null
                          ? const CircleAvatar(
                              backgroundColor: Colors.grey,
                            )
                          : CircleAvatar(
                              child: ClipOval(
                                  child: Image.file(imagemSelecionada!)),
                            ),
                      Positioned(
                        right: -12,
                        bottom: 0,
                        child: Container(
                          child: IconButton(
                            onPressed: () {
                              editarFoto();
                              pegarImagemGaleria();
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 30),
                /*
                * Nome
                */
                Text(
                  pvdUsuario.usuario!.displayName!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              height: 50,
              thickness: 1,
              color: Colors.grey,
            ),
            /*
            * Informações pessoais
            */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Informações pessoais',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            /*
            * Nome e data de nascimento
            */

            CampoTexto(
              labelText: 'Nome',
              focusNode: _campoNome,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_campoNome);
              },
              textInputAction: TextInputAction.next,
              controller: _nome,
              prefixIcon: const Icon(Icons.person),
              keyboardType: TextInputType.name,
              enabled: true,
              suffixIcon: IconButton(
                // ignore: avoid_print
                onPressed: () => print('teste'),
                icon: const Icon(Icons.edit),
              ),
            ),
            CampoTexto(
              labelText: 'Data de nascimento',
              focusNode: _campoDataNascimento,
              inputFormatters: [mascaraDataNascimento],
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_campoDataNascimento);
              },
              textInputAction: TextInputAction.next,
              controller: _dataNascimento,
              prefixIcon: const Icon(Icons.date_range),
              keyboardType: TextInputType.datetime,
              enabled: true,
              suffixIcon: IconButton(
                // ignore: avoid_print
                onPressed: () => print('teste'),
                icon: const Icon(Icons.edit),
              ),
            ),
            /*
            * Informações de contato
            */
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                'Informações de contato',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CampoTexto(
              labelText: 'E-mail',
              focusNode: _campoEmail,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_campoEmail);
              },
              textInputAction: TextInputAction.next,
              controller: _email,
              prefixIcon: const Icon(Icons.email),
              keyboardType: TextInputType.emailAddress,
              // TODO: Editar campo de texto
              enabled: true,
              suffixIcon: IconButton(
                // ignore: avoid_print
                onPressed: () => print('teste'),
                icon: const Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 10),
            CampoTexto(
              labelText: 'Telefone',
              focusNode: _campoTelefone,
              inputFormatters: [mascaraTelefone],
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_campoTelefone);
              },
              textInputAction: TextInputAction.next,
              controller: _telefone,
              prefixIcon: const Icon(Icons.phone),
              keyboardType: TextInputType.phone,
              enabled: true,
              suffixIcon: IconButton(
                // ignore: avoid_print
                onPressed: () => print('teste'),
                icon: const Icon(Icons.edit),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 20),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Alterar senha',
                  style: GoogleFonts.oxygen(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            /*
            * Botões da parte inferior
            */
            Padding(
              padding: const EdgeInsets.only(top: 40, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PopupDialog(
                            titulo: 'Tem certeza que deseja excluir sua conta?',
                            yesLabel: 'Sim',
                            noLabel: 'Não',
                            onPressedNoOption: () {
                              Navigator.of(context).pop();
                            },
                            onPressedYesOption: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    label: Text(
                      'Excluir minha conta',
                      style: GoogleFonts.oxygen(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  Botao(
                    onPressed: () {},
                    labelText: 'Salvar',
                    internalPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
