import 'package:flutter/material.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _campoNome = FocusNode();
  final _campoSenha = FocusNode();
  final _campoEmail = FocusNode();
  final _campoTelefone = FocusNode();

  // Verificações de edição de campo
  bool editingName = false;
  bool editingPassword = false;
  bool editingEmail = false;
  bool editingPhone = false;

  // Máscara para telefone.
  var mascaraTelefone = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  //Libera os recursos após sair da tela ou salvar os dados
  @override
  void dispose() {
    super.dispose();
    _campoNome.dispose();
    _campoSenha.dispose();
    _campoEmail.dispose();
    _campoTelefone.dispose();
  }

  // Campos de texto.
  final _nome = TextEditingController();
  final _senha = TextEditingController();
  final _email = TextEditingController();
  final _telefone = TextEditingController();

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
    userPhotoURL = Provider.of<ProviderUsuario>(
      context,
      listen: false,
    ).usuario!.photoURL;

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
                Text(
                  pvdUsuario.usuario!.displayName!,
                  style: GoogleFonts.oxygen(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
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
            * Nome
            */
            Row(
              children: [
                if (!editingName)
                  Text(
                    'Nome: ',
                    style: GoogleFonts.oxygen(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (!editingName)
                  Expanded(
                    child: Text(
                      pvdUsuario.usuario!.displayName!,
                      style: GoogleFonts.oxygen(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                  ),
                if (editingName)
                  Expanded(
                    child: CampoTexto(
                      labelText: 'Nome',
                      focusNode: _campoNome,
                      textInputAction: TextInputAction.next,
                      controller: _nome,
                      prefixIcon: const Icon(Icons.person),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                IconButton(
                  onPressed: () {
                    setState(() => editingName = !editingName);
                  },
                  icon: Icon(
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
                if (!editingPassword)
                  Text(
                    'Senha: ',
                    style: GoogleFonts.oxygen(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (!editingPassword)
                  Expanded(
                    child: Text(
                      '************',
                      style: GoogleFonts.oxygen(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                  ),
                if (editingPassword)
                  Expanded(
                    child: CampoTexto(
                      labelText: 'Senha',
                      focusNode: _campoSenha,
                      textInputAction: TextInputAction.next,
                      controller: _senha,
                      prefixIcon: const Icon(Icons.lock),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                IconButton(
                  onPressed: () {
                    setState(() => editingPassword = !editingPassword);
                  },
                  icon: Icon(
                    (editingPassword) ? Icons.check : Icons.edit,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            /*
            * Senha
            */
            // CampoTexto(
            //   labelText: 'Senha',
            //   focusNode: _campoSenha,
            //   obscureText: true,
            //   onFieldSubmitted: (_) {
            //     FocusScope.of(context).requestFocus(_campoSenha);
            //   },
            //   textInputAction: TextInputAction.next,
            //   controller: _senha,
            //   prefixIcon: const Icon(Icons.lock),
            //   keyboardType: TextInputType.visiblePassword,
            //   enabled: true,
            //   suffixIcon: IconButton(
            //     // ignore: avoid_print
            //     onPressed: () => print('teste'),
            //     icon: const Icon(Icons.edit),
            //   ),
            // ),
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
            /*
            * Telefone
            */
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
                  // Botao(
                  //   onPressed: () {},
                  //   labelText: 'Salvar',
                  //   internalPadding: const EdgeInsets.symmetric(
                  //     horizontal: 20,
                  //     vertical: 15,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
