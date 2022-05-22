import 'package:flutter/material.dart';
import 'package:garagem_burger/components/app_bar_button.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/controllers/provider_carrinho.dart';
import 'package:garagem_burger/controllers/provider_usuario.dart';
import 'package:garagem_burger/pages/tela_vazia.dart';
import 'package:garagem_burger/utils/rotas.dart';
import 'package:garagem_burger/components/botao_com_seta.dart';
import 'package:garagem_burger/pages/perfil/tela_configuracoes.dart';
import 'package:garagem_burger/pages/cartoes/tela_meus_cartoes.dart';
import 'package:garagem_burger/pages/perfil/tela_meus_pedidos.dart';
import 'package:garagem_burger/pages/localizacao/tela_minhas_localizacoes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class TelaPerfil extends StatefulWidget {
  const TelaPerfil({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Perfil';

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  @override
  Widget build(BuildContext context) {
    // Altura total da tela, subtraindo as alturas da appBar e bottomBar
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight! -
        kBottomNavigationBarHeight;

    final pvdUsuario = Provider.of<ProviderUsuario>(context);
    if ((pvdUsuario.usuario == null)) {
      return TelaVazia(
        pageName: 'Perfil',
        icon: Icons.person,
        titulo: 'FAÇA LOGIN PARA CONTINUAR',
        subtitulo: 'Você precisa estar logado amiguinho.',
        rodape: '',
        navigator: () => Navigator.of(context).pushReplacementNamed(
          Rotas.home,
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: availableHeight * 0.20,
                  child: (pvdUsuario.usuario!.photoURL != null)
                      ? ClipOval(
                          child: FadeInImage.assetNetwork(
                            image: pvdUsuario.usuario!.photoURL!,
                            placeholder: 'images/placeholder-perfil.png',
                            fit: BoxFit.cover,
                            placeholderFit: BoxFit.cover,
                          ),
                        )
                      : ClipOval(
                          child: Image.asset(
                            'images/placeholder-perfil.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                const SizedBox(width: 30),
                CustomText(
                  pvdUsuario.usuario!.displayName!,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
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
                  BotaoComSeta(
                    text: 'Meus Pedidos',
                    icon: Icons.shopping_cart_outlined,
                    onTap: () => Navigator.of(context).pushNamed(
                      Rotas.main,
                      arguments: {
                        'index': 3,
                        'page': const TelaMeusPedidos(),
                        'button': null,
                      },
                    ),
                  ),
                  BotaoComSeta(
                    text: 'Minhas Localizações',
                    icon: Icons.location_on_outlined,
                    onTap: () => Navigator.of(context).pushNamed(
                      Rotas.main,
                      arguments: {
                        'index': 3,
                        'page': const TelaMinhasLocalizacoes(),
                        'button': const AppBarButton(
                          icon: Icons.add_location_alt_outlined,
                          tipoFuncao: TipoFuncao.adicionarLocalizacao,
                        ),
                      },
                    ),
                  ),
                  BotaoComSeta(
                    text: 'Meus Cartões',
                    icon: Icons.credit_card_outlined,
                    onTap: () => Navigator.of(context).pushNamed(
                      Rotas.main,
                      arguments: {
                        'index': 3,
                        'page': const TelaMeusCartoes(),
                        'button': const AppBarButton(
                          icon: Icons.add_card,
                          tipoFuncao: TipoFuncao.adicionarCartao,
                        ),
                      },
                    ),
                  ),
                  BotaoComSeta(
                    text: 'Configurações',
                    icon: Icons.settings,
                    onTap: () => Navigator.of(context).pushNamed(
                      Rotas.main,
                      arguments: {
                        'index': 3,
                        'page': const TelaConfiguracoes(),
                        'button': null,
                      },
                    ),
                  ),
                  BotaoComSeta(
                    text: 'Sair',
                    icon: Icons.exit_to_app,
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        Rotas.home,
                        (_) => false,
                      );
                      if (pvdUsuario.usuario != null) {
                        pvdUsuario.logout();
                      }
                      Provider.of<ProviderCarrinho>(
                        context,
                        listen: false,
                      ).clearAll();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
