import 'package:flutter/material.dart';
import 'package:garagem_burger/models/pedido.dart';

class CardPedido extends StatelessWidget {
  final Pedido pedido;

  const CardPedido(
    this.pedido, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    // Altura total da tela, subtraindo as alturas da appBar e bottomBar
    final availableHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight! -
        kBottomNavigationBarHeight;

    switch (pedido.status) {
      case Status.entregue:
        color = Colors.green;
        icon = Icons.check_circle_outline;
        break;
      case Status.pendente:
        color = const Color(0xfffed80b);
        icon = Icons.error_outline;
        break;
      case Status.cancelado:
        color = Colors.red;
        icon = Icons.cancel_outlined;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
      ),
      child: SizedBox(
        height: availableHeight * 0.20,
        /*
        * Layout Builder
        */
        child: LayoutBuilder(
          builder: (ctx, constraints) => GestureDetector(
            onTap: () {}, // TODO: Navegar para tela de Visualizar Pedido
            child: Card(
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                  width: 2.0,
                  color: color,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*
                    * Leading (Imagem)
                    */
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      image: DecorationImage(
                        image: AssetImage('images/pedido.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: constraints.maxWidth * 0.30,
                  ),
                  /*
                    * Title e Subtitle
                    */
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: constraints.maxWidth * 0.55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        /*
                          * Title
                          */
                        Text(
                          'Pedido ${pedido.status.name} em ${pedido.data}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        /*
                          * Subtitle
                          */
                        Text(
                          'às ${pedido.hora}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*
                  * Trailing (icone de status do pedido)
                  */
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.10,
                        child: Icon(
                          icon,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.15),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
