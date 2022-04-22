import 'package:flutter/material.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({Key? key}) : super(key: key);

  @override
  State<TelaConfiguracoes> createState() => TelaConfiguracoesState();
}

class TelaConfiguracoesState extends State<TelaConfiguracoes> {
  final String name = 'Nome do usuário';

  void editarFoto() {
    // ignore: avoid_print
    print("editar foto");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
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
                          width: 46,
                          height: 46,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
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
        ],
      ),
    );
  }
}
