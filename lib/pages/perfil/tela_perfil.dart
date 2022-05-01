import 'package:flutter/material.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:garagem_burger/components/botao_branco.dart';
import 'package:garagem_burger/pages/perfil/tela_configuracoes.dart';
import 'package:garagem_burger/pages/perfil/tela_meus_cartoes.dart';
import 'package:garagem_burger/pages/perfil/tela_meus_pedidos.dart';
import 'package:garagem_burger/pages/perfil/tela_minhas_localizacoes.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class TelaPerfil extends StatefulWidget {
  const TelaPerfil({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Perfil';

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

// ignore: camel_case_types
class _TelaPerfilState extends State<TelaPerfil> {
  final String name = 'Miyamura Tanaki';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),

          // ListTile(
          //   leading: const CircleAvatar(
          //     backgroundColor: Colors.grey,
          //     backgroundImage: AssetImage("images/profile.png"),
          //   ),
          //   title: Text(
          //     name,
          //     style: GoogleFonts.oxygen(
          //       color: Colors.black,
          //       fontSize: 18,
          //       fontWeight: FontWeight.bold,
          //       decoration: TextDecoration.none,
          //     ),
          //   ),
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              Text(
                name,
                style: GoogleFonts.oxygen(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Divider(
            height: 20,
            thickness: 1,
            indent: 5,
            endIndent: 5,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 10.0,
            ),
            child: Column(
              children: [
                BotaoBranco(
                  text: 'Meus Pedidos',
                  icon: Icons.shopping_cart_outlined,
                  onTap: () => Navigator.of(context).pushNamed(
                    Rotas.main,
                    arguments: [3, const TelaMeusPedidos()],
                  ),
                ),
                BotaoBranco(
                  text: 'Minhas Localizações',
                  icon: Icons.location_on_outlined,
                  onTap: () => Navigator.of(context).pushNamed(
                    Rotas.main,
                    arguments: [3, const TelaMinhasLocalizacoes()],
                  ),
                ),
                BotaoBranco(
                  text: 'Meus Cartões',
                  icon: Icons.credit_card_outlined,
                  onTap: () => Navigator.of(context).pushNamed(
                    Rotas.main,
                    arguments: [3, const TelaMeusCartoes()],
                  ),
                ),
                BotaoBranco(
                  text: 'Configurações',
                  icon: Icons.settings,
                  onTap: () => Navigator.of(context).pushNamed(
                    Rotas.main,
                    arguments: [3, const TelaConfiguracoes()],
                  ),
                ),
                BotaoBranco(
                  text: 'Sair',
                  icon: Icons.exit_to_app,
                  onTap: () => Navigator.of(context).pushReplacementNamed(
                    Rotas.home,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
