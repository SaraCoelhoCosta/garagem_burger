import 'package:flutter/material.dart';
import 'package:garagem_burger/components/botao.dart';
import 'package:garagem_burger/components/custom_text.dart';
import 'package:garagem_burger/components/popup_dialog.dart';
import 'package:garagem_burger/pages/menu/tela_menu.dart';
import 'package:garagem_burger/utils/rotas.dart';

class TelaMontarHamburguer extends StatefulWidget {
  const TelaMontarHamburguer({Key? key}) : super(key: key);

  @override
  State<TelaMontarHamburguer> createState() => _TelaMontarHamburguerState();
}

class _TelaMontarHamburguerState extends State<TelaMontarHamburguer> {
  int _currentStep = 0;
  bool creationBeginning = false;

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  //TODO: Função não está funcionando, aparentemente. Ou é alguma lógica lá embaixo
  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('images/fundo-hamburguer.jpeg'),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Botao voltar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => PopupDialog(
                        titulo: 'Confirmar cancelamento?',
                        descricao:
                            'A montagem do seu hambúrguer será descartada',
                        yesLabel: 'Sim',
                        noLabel: 'Não',
                        onPressedNoOption: () {
                          Navigator.of(context).pop();
                        },
                        onPressedYesOption: () {
                          setState(() {
                            creationBeginning = true;
                          });
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            Rotas.main,
                            (_) => false,
                            arguments: {
                              'index': 0,
                              'page': const TelaMenu(),
                              'button': null,
                            },
                          );
                        },
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            //Titulo
            !creationBeginning
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Botao(
                          onPressed: () {
                            setState(() {
                              creationBeginning = true;
                            });
                          },
                          labelText: 'Começar',
                          internalPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomText(
                        'Inicie uma\ncriativa jornada\npara matar a\nfome do\nseu jeito',
                        bordered: true,
                        textAlign: TextAlign.center,
                        color: Colors.white,
                        fontSize: 45.0,
                        fontType: FontType.title,
                      )
                    ],
                  )
                : Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.75,
                    color: Colors.white,
                    child: Stepper(
                      type: StepperType.horizontal,
                      physics: const ScrollPhysics(),
                      currentStep: _currentStep,
                      onStepTapped: (step) => tapped(step),
                      onStepContinue: () {
                        if (_currentStep != 2) {
                          continued;
                        } else if (_currentStep == 2) {
                          StepState.complete;
                          showDialog(
                            context: context,
                            builder: (context) => PopupDialog(
                              isTextField: true,
                              titulo: 'Nome do hambúrguer',
                              descricao:
                                  'Para finalizar, dê nome à sua criatividade',
                              yesLabel: 'OK',
                              noLabel: 'Cancelar',
                              onPressedNoOption: () {
                                StepState.disabled;
                                Navigator.of(context).pop();
                              },
                              onPressedYesOption: () {
                                setState(() {
                                  creationBeginning = true;
                                });
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  Rotas.main,
                                  (_) => false,
                                  arguments: {
                                    'index': 0,
                                    'page': const TelaMenu(),
                                    'button': null,
                                  },
                                );
                              },
                            ),
                          );
                        }
                      },
                      onStepCancel: cancel,
                      steps: <Step>[
                        Step(
                          title: const CustomText('Pão'),
                          content: const CustomText('Escolha o pão'),
                          isActive: _currentStep >= 0,
                          state: _currentStep > 0
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: const CustomText('Carne'),
                          content: const CustomText('Escolha a carne'),
                          isActive: _currentStep >= 0,
                          state: _currentStep > 1
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: const CustomText('Outros'),
                          content: const CustomText('Escolha os ingredientes'),
                          isActive: _currentStep >= 0,
                          state: _currentStep > 2
                              ? StepState.complete
                              : StepState.disabled,
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
