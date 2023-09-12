import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juego_memoria/modules/game/cubit/game_cubit.dart';
import 'package:juego_memoria/widgets/card_poker.dart';
import 'package:juego_memoria/widgets/custom_button.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final CountdownController _countdownController = CountdownController();
  int color = 100;
  bool isSelected = false;
  late GameCubit cubit;
  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 40, 72),
      body: BlocProvider(
        create: (context) => GameCubit()..getAll(context: context),
        child: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            cubit = context.read<GameCubit>();
            if(state.status == GameEstatus.finishGame){
              _countdownController.pause();
            }
            if(state.status == GameEstatus.isSelecting){
              isSelected = false;
            }
            if(state.status == GameEstatus.incorrectCards){
              isSelected = true;
            }
            return Center(
              child: Padding(
                padding: EdgeInsets.all(sizeHeight * 0.009),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: sizeHeight *0.03,
                    ),
                    Countdown(
                      controller: _countdownController,
                      seconds: 60,
                      build: (_, double time) => Text(
                        'Tiempo restante: $time segundos',
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      interval: const Duration(milliseconds: 100),
                      onFinished: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Se acabo')),
                        );
                        cubit.showGameOver(context: context);
                      },
                    ),
                    SizedBox(height: sizeHeight * 0.01,),
                    Text(
                      'Puntaje: ${cubit.puntaje}',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: sizeHeight * 0.04,
                    ),
                    Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage('assets/baraja/fondo.png'),),
                          border: Border.all(width: 2),
                          color: const Color.fromARGB(255, 54, 61, 107),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        // color: const Color.fromARGB(255, 54,61,107),
                        // https://api.flutter.dev/flutter/widgets/GridView-class.html
                        child: state.lsCartas.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : GridView.builder(
                                primary: false,
                                padding: EdgeInsets.only(
                                  left: sizeHeight *0.01,
                                  right: sizeHeight *0.01,
                                  top: sizeHeight *0.04,
                                  bottom: sizeHeight * 0.04,
                                ),
                                itemCount: state.lsCartas.length,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisExtent: sizeHeight * 0.138,
                                  crossAxisSpacing: sizeWidth *0.015,
                                  mainAxisSpacing: sizeHeight * 0.015,
                                ),
                                itemBuilder: (context, index) {
                                // final colors = cartasProvider.cartas[index];
                                  final carta = state.lsCartas[index];
                                  return IgnorePointer(
                                    ignoring:  !isSelected,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      color: Colors.teal[cubit.colors[index]],
                                      child: CardPoker(
                                        nombre: carta.name,
                                        imgFront: carta.imageUrl,
                                        // isSelected: isSelected,
                                        onPressed: () {
                                          log('###########');
                                          cubit.selectedCard(
                                            card: state.lsCartas[index].name, 
                                            context: context,
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                               
                              ),
                      ),
                    ),
                    SizedBox(
                      height: sizeHeight * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                          height: sizeHeight * 0.055,
                          width: sizeWidth * 0.4,
                          customFontSize: 15,
                          buttonText: 'Iniciar Juego',
                          icon: Icons.play_arrow,
                          onPressed: () {
                            _countdownController.start();
                            setState(() {
                              isSelected = true;
                            });
                          },
                          color: const Color.fromARGB(255, 39, 175, 97),
                        ),
                        CustomButton(
                          height: sizeHeight * 0.055,
                          width: sizeWidth * 0.4,
                          customFontSize: 15,
                          buttonText: 'Jugar de nuevo',
                          icon: Icons.play_arrow_outlined,
                          onPressed: () {
                            _countdownController.restart();
                            cubit.newGame();
                            setState(() {
                              isSelected = true;
                            });
                          },
                          color: const Color.fromARGB(255, 39, 175, 97),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sizeHeight * 0.02,
                    ),
                    CustomButton(
                      height: sizeHeight * 0.055,
                      width: sizeWidth * 0.3,
                      customFontSize: 15,
                      buttonText: 'Salir',
                      icon: Icons.exit_to_app,
                      color: const Color.fromARGB(255, 239, 40, 75),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
