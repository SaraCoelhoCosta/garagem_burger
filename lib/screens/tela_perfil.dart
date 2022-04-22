import 'package:flutter/material.dart';
import 'package:garagem_burger/screens/components/botao_transparente.dart';

// ignore: camel_case_types
class TelaPerfil extends StatefulWidget {

  const TelaPerfil({Key? key}) : super(key: key);

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

// ignore: camel_case_types
class _TelaPerfilState extends State<TelaPerfil> {
  final String name = 'Nome do usuário';

/*
  void testeMeusPedidos() {
    // ignore: avoid_print
    print("Meus pedidos");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MeusPedidos()),
    );
  }

  void enderecosCadastrados() {
    // ignore: avoid_print
    print("Endereços cadastrados");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EnderecosCadastrados()),
    );
  }

  void meusCartoes() {
    // ignore: avoid_print
    print("Meus Cartões");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MeusCartoes()),
    );
  }

  void configuracoes() {
    // ignore: avoid_print
    print("Configurações");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Configuracoes()),
    );
  }

  void sair() {
    // ignore: avoid_print
    print("Sair");
    //Só desloga da conta (e volta pra Login) ou sai do app?
    //exit(0);
  }
*/
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage("images/profile.png"),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 50),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),

          const Divider(
            height: 20,
            thickness: 1,
            indent: 5,
            endIndent: 5,
            color: Colors.black,
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 10.0,
            ),
            child: Column(
              children: const [
                BotaoTransparente(
                  text: 'Meus Pedidos',
                  icon: Icons.shopping_cart_outlined,
                ),
                BotaoTransparente(
                  text: 'Minhas Localizações',
                  icon: Icons.location_on_outlined,
                ),
                BotaoTransparente(
                  text: 'Meus Cartões',
                  icon: Icons.credit_card_outlined,
                ),
                BotaoTransparente(
                  text: 'Configurações',
                  icon: Icons.settings,
                ),
                BotaoTransparente(
                  text: 'Sair',
                  icon: Icons.exit_to_app,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
