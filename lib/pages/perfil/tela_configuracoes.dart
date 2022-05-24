import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/components/custom_text_field.dart';
import 'package:garagem_burger/components/popup_dialog.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _campoNome = FocusNode();
  final _campoTelefone = FocusNode();

  // Verificações de edição de campo
  bool editingName = false;
  bool loadingName = false;
  bool editingPhone = false;
  bool loadingPhone = false;
  bool flag = false;

  // Máscara para telefone.
  var mascaraTelefone = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  //Libera os recursos após sair da tela ou salvar os dados
  @override
  void dispose() {
    super.dispose();
    _campoNome.dispose();
    _campoTelefone.dispose();
  }

  // Campos de texto.
  final _nome = TextEditingController();
  final _telefone = TextEditingController();

  Map<String, dynamic> dadosUsuario = {};

  String? userPhotoURL;
  bool updatingPhoto = false;

  Future<void> pickAndUploadImage(BuildContext context) async {
    final pvdUsuario = Provider.of<ProviderUsuario>(
      context,
      listen: false,
    );

    // Captura a imagem da galeria
    final ImagePicker _picker = ImagePicker();
    XFile? tempImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    // Salva a imagem no Firebase Storage
    if (tempImage != null) {
      setState(() => updatingPhoto = true);
      await pvdUsuario.addPhoto(pvdUsuario.usuario, tempImage.path);
      setState(() {
        updatingPhoto = false;
        userPhotoURL = pvdUsuario.usuario!.photoURL;
      });
    }
  }

  @override
  void initState() {
    final pvdUsuario = Provider.of<ProviderUsuario>(
      context,
      listen: false,
    );

    userPhotoURL = pvdUsuario.usuario!.photoURL;

    dadosUsuario = pvdUsuario.userData ?? {};

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Altura total da tela, subtraindo as alturas da appBar e bottomBar
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight! -
        kBottomNavigationBarHeight;

    final pvdUsuario = Provider.of<ProviderUsuario>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
        child: Column(
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
                SizedBox.square(
                  dimension: availableHeight * 0.20,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      if (updatingPhoto)
                        const ClipOval(child: CircularProgressIndicator())
                      else if (userPhotoURL != null)
                        ClipOval(
                          child: Image.network(
                            userPhotoURL!,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        ClipOval(
                          child: Image.asset(
                            'images/placeholder-perfil.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      Positioned(
                        right: -12,
                        bottom: 0,
                        child: Container(
                          child: IconButton(
                            splashRadius: 20,
                            onPressed: () => pickAndUploadImage(context),
                            iconSize: 20,
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.grey,
                            ),
                          ),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey,
                            ),
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
                CustomText(
                  pvdUsuario.usuario!.displayName ?? '',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ],
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  /*
                  * Informações pessoais
                  */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CustomText(
                        'Informações pessoais',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  /*
                  * Nome
                  */
                  Row(
                    children: [
                      if (!editingName)
                        const CustomText(
                          'Nome: ',
                          fontWeight: FontWeight.bold,
                        ),
                      if (!editingName)
                        Expanded(
                          child: CustomText(
                            pvdUsuario.usuario!.displayName ?? '',
                            color: Colors.grey[700],
                          ),
                        ),
                      if (editingName)
                        Expanded(
                          child: CustomTextField(
                            labelText: 'Nome',
                            focusNode: _campoNome,
                            enabled: !loadingName,
                            textInputAction: TextInputAction.done,
                            controller: _nome,
                            prefixIcon: const Icon(Icons.person),
                            keyboardType: TextInputType.name,
                            validator: (_nome) {
                              if (_nome!.isEmpty || _nome == '') {
                                print('nome empty');
                                setState(() {
                                  flag = true;
                                });
                                return 'Insira um nome válido';
                              } else if (_nome.length < 3) {
                                setState(() {
                                  flag = true;
                                });
                                return 'O nome deve conter ao menos 4 letras';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) async {
                              setState(() {
                                editingName = !editingName;
                                if (!editingName) {
                                  loadingName = true;
                                }
                              });
                              dadosUsuario['nome'] = _nome.text;
                              await pvdUsuario.updateUsuario(
                                pvdUsuario.usuario,
                                dadosUsuario,
                              );
                              setState(() => loadingName = false);
                            },
                          ),
                        ),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            editingName = !editingName;
                            if (!editingName) {
                              loadingName = true;
                            }
                          });

                          if (!editingName) {
                            dadosUsuario['nome'] = _nome.text;
                            await pvdUsuario.updateUsuario(
                              pvdUsuario.usuario,
                              dadosUsuario,
                            );
                          } else {
                            FocusScope.of(context).requestFocus(_campoNome);
                          }

                          setState(() => loadingName = false);
                        },
                        icon: (loadingName)
                            ? const CircularProgressIndicator()
                            : Icon(
                                (editingName) ? Icons.check : Icons.edit,
                                color: Colors.grey[700],
                              ),
                      ),
                    ],
                  ),
                  /*
                  * Senha
                  */
                  Row(
                    children: [
                      const CustomText(
                        'Senha: ',
                        fontWeight: FontWeight.bold,
                      ),
                      Expanded(
                        child: CustomText(
                          '************',
                          color: Colors.grey[700],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          //TODO: Aumentar a largura do popup, pois a descrição
                          // "Sua sua deve ter no mínimo 6 caracteres" n aparece por completo
                          showDialog(
                            context: context,
                            builder: (context) {
                              return PopupDialog(
                                isPassword: true,
                                titulo: 'Alterar senha',
                                yesLabel: 'Confirmar',
                                noLabel: 'Cancelar',
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
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
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
                  /*
                  * Email
                  */

                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        const CustomText(
                          'E-mail: ',
                          fontWeight: FontWeight.bold,
                        ),
                        Expanded(
                          child: CustomText(
                            pvdUsuario.usuario!.email!,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*
                  * Telefone
                  */
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (!editingPhone)
                        const CustomText(
                          'Telefone: ',
                          fontWeight: FontWeight.bold,
                        ),
                      if (!editingPhone)
                        Expanded(
                          child: CustomText(
                            dadosUsuario['telefone'] ?? 'Sem telefone',
                            color: Colors.grey[700],
                          ),
                        ),
                      if (editingPhone)
                        Expanded(
                          child: CustomTextField(
                            labelText: 'Telefone',
                            focusNode: _campoTelefone,
                            inputFormatters: [mascaraTelefone],
                            textInputAction: TextInputAction.done,
                            controller: _telefone,
                            prefixIcon: const Icon(Icons.phone),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 11) {
                                setState(() {
                                  flag = true;
                                });
                                return 'Telefone inválido';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) async {
                              setState(() {
                                editingPhone = !editingPhone;
                                if (!editingPhone) {
                                  loadingPhone = true;
                                }
                              });
                              if (!editingPhone) {
                                dadosUsuario['telefone'] = _telefone.text;
                                await pvdUsuario.updateUsuario(
                                  pvdUsuario.usuario,
                                  dadosUsuario,
                                );
                              } else {
                                FocusScope.of(context)
                                    .requestFocus(_campoTelefone);
                              }
                              setState(() => loadingPhone = false);
                            },
                          ),
                        ),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            editingPhone = !editingPhone;
                            if (!editingPhone) {
                              loadingPhone = true;
                            }
                          });
                          dadosUsuario['telefone'] = _telefone.text;
                          await pvdUsuario.updateUsuario(
                            pvdUsuario.usuario,
                            dadosUsuario,
                          );
                          setState(() => loadingPhone = false);
                        },
                        icon: (loadingPhone)
                            ? const CircularProgressIndicator()
                            : Icon(
                                (editingPhone) ? Icons.check : Icons.edit,
                                color: Colors.grey[700],
                              ),
                      ),
                    ],
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
                                  titulo:
                                      'Tem certeza que deseja excluir sua conta?',
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
                          label: const CustomText(
                            'Excluir minha conta',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Botao(
                          onPressed: () {
                            //TODO: O botão salvar vai realmente salvar ou só voltar?
                            // De qlqr forma, eu deixaria pra pelo menos 'parecer' que salvou,
                            // mas pode tirar, se quiser

                            //TODO: Não está funcionando (n sei pq).
                            if (flag == true) {
                              print('teste');
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return PopupDialog(
                                    titulo: 'Preencha os campos corretamente',
                                    yesLabel: 'OK',
                                    onPressedYesOption: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              );
                            } else {
                              Navigator.of(context).pop;
                            }
                          },
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
          ],
        ),
      ),
    );
  }
}
