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
  final String name = 'Miyamura Tanaki';

  void editarFoto() {
    // ignore: avoid_print
    print("editar foto");
  }

  @override
  Widget build(BuildContext context) {
    final pvdUsuario = Provider.of<ProviderUsuario>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    /*backgroundImage:
                              AssetImage("assets/images/profile2.jpg")*/
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
        const SizedBox(
          height: 20,
        ),
        const Divider(
          height: 20,
          thickness: 1,
          indent: 5,
          endIndent: 5,
          color: Colors.grey,
        ),
        Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 25, left: 15),
                  child: Text(
                    'Informações pessoais',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
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
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: CampoTexto(
                    obscureText: false,
                    labelText: 'Nome',
                    prefixIcon: const Icon(Icons.person),
                    keyboardType: TextInputType.name,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: CampoTexto(
                    obscureText: false,
                    labelText: 'Data de nascimento',
                    prefixIcon: const Icon(Icons.date_range),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40, bottom: 25, left: 15),
              child: Text(
                'Informações de contato',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                CampoTexto(
                  obscureText: false,
                  labelText: 'E-mail',
                  prefixIcon: const Icon(Icons.email),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                CampoTexto(
                  obscureText: false,
                  labelText: 'Telefone',
                  prefixIcon: const Icon(Icons.phone),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 0, right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        horizontal: 20, vertical: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
