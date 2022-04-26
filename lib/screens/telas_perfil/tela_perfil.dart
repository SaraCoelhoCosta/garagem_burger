import 'package:flutter/material.dart';
import 'package:garagem_burger/rotas.dart';
import 'package:garagem_burger/screens/components/botao_transparente.dart';
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
  final String name = 'Nome do usuário';

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
              const SizedBox(width: 60),
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
                BotaoTransparente(
                  text: 'Meus Pedidos',
                  icon: Icons.shopping_cart_outlined,
                  onTap: () => Rotas.nvgComRetorno(
                    context: context,
                    rota: Rotas.meusPedidos,
                  ),
                ),
                BotaoTransparente(
                  text: 'Minhas Localizações',
                  icon: Icons.location_on_outlined,
                  onTap: () => Rotas.nvgComRetorno(
                    context: context,
                    rota: Rotas.minhasLocalizacoes,
                  ),
                ),
                BotaoTransparente(
                  text: 'Meus Cartões',
                  icon: Icons.credit_card_outlined,
                  onTap: () => Rotas.nvgComRetorno(
                    context: context,
                    rota: Rotas.meusCartoes,
                  ),
                ),
                BotaoTransparente(
                  text: 'Configurações',
                  icon: Icons.settings,
                  onTap: () => Rotas.nvgComRetorno(
                    context: context,
                    rota: Rotas.configuracoes,
                  ),
                ),
                BotaoTransparente(
                  text: 'Sair',
                  icon: Icons.exit_to_app,
                  onTap: () => Rotas.nvgSemRetorno(
                    context: context,
                    rota: Rotas.abertura,
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
