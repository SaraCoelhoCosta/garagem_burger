import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/campo_texto.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  Widget build(BuildContext context) {
    final pvdUsuario = Provider.of<ProviderUsuario>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
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
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage("images/profile.png"),
                      ),
                      Positioned(
                        right: -10,
                        bottom: 0,
                        child: TextButton(
                          onPressed: editarFoto,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.grey,
                              size: 20,
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
              height: 20,
              thickness: 1,
              color: Colors.grey,
            ),
            /*
            * Informações pessoais
            */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Informações pessoais',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
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
              ],
            ),
            /*
            * Nome e data de nascimento
            */
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: CampoTexto(
                    labelText: 'Nome',
                    prefixIcon: const Icon(Icons.person),
                    keyboardType: TextInputType.name,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: CampoTexto(
                    labelText: 'Data de nascimento',
                    prefixIcon: const Icon(Icons.date_range),
                    keyboardType: TextInputType.datetime,
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
            CampoTexto(
              labelText: 'E-mail',
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
              prefixIcon: const Icon(Icons.phone),
              keyboardType: TextInputType.phone,
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
                    onPressed: () {},
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
