import 'package:flutter/material.dart';
import 'package:garagem_burger/components/custom_arrow_button.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/controllers/cart.dart';
import 'package:garagem_burger/controllers/pages.dart';
import 'package:garagem_burger/utils/routes.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  String toStringShort() => 'Perfil';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // Altura total da tela, subtraindo as alturas da appBar e bottomBar
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight! -
        kBottomNavigationBarHeight;

    final pvdPages = Provider.of<Pages>(context);

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
                child: ClipOval(
                  child: Image.asset(
                    'images/placeholder-perfil.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 30),
              const CustomText(
                'Convidado',
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
                CustomArrowButton(
                  text: 'Meus Pedidos',
                  icon: Icons.shopping_cart_outlined,
                  onTap: () {},
                ),
                CustomArrowButton(
                  text: 'Minhas Localizações',
                  icon: Icons.location_on_outlined,
                  onTap: () {},
                ),
                CustomArrowButton(
                  text: 'Meus Cartões',
                  icon: Icons.credit_card_outlined,
                  onTap: () {},
                ),
                CustomArrowButton(
                  text: 'Configurações',
                  icon: Icons.settings,
                  onTap: () {},
                ),
                CustomArrowButton(
                  text: 'Sair',
                  icon: Icons.exit_to_app,
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.home,
                      (_) => false,
                    );

                    Provider.of<Cart>(
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
