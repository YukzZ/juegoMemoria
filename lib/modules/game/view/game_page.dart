
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juego_memoria/data/provider/cartas_provider.dart';
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
  final CountdownController _countdownController = 
    CountdownController();
    int color = 100;
  @override
  Widget build(BuildContext context) {
    final cartasProvider = context.watch<CartasProvider>();
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 35,40,72),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 30,),
              Countdown(
                controller: _countdownController,
                seconds: 60, 
                build: (_, double time) => Text(
                  'Tiempo restante: $time segundos',
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white
                  ),
                ),
                interval: const Duration(milliseconds: 100),
                onFinished: (){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Se acabo')),
                  );
                },
              ),
              const Text(
                'Puntaje: 0',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image:  const DecorationImage(image: AssetImage('assets/baraja/fondo.png')),
                    border: Border.all(width: 2),
                    color: const Color.fromARGB(255, 54,61,107),
                    borderRadius: BorderRadius.circular(40),
                    
                  ),
                  // color: const Color.fromARGB(255, 54,61,107),
                  // https://api.flutter.dev/flutter/widgets/GridView-class.html
                  child: cartasProvider.initialLoading
                  ? const Center(child: CircularProgressIndicator(),)
                  : GridView.builder(
                    primary: false,
                    padding: const EdgeInsets.only(
                      left: 10, 
                      right: 10, 
                      top: 40,
                    ),
                    itemCount: cartasProvider.cartas.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final carta = cartasProvider.cartas[index];
                      
                      return Container(
                        padding: const EdgeInsets.all(4),
                        color: Colors.teal[carta.color],
                        child: CardPoker(imgFront: carta.imageUrl),
                      );
                    },
                    // crossAxisSpacing: 10,
                    // mainAxisSpacing: 10,
                    // crossAxisCount: 3,
                    // children: [
                      
                    //   Container(
                    //     padding: const EdgeInsets.all(4),
                    //     color: Colors.teal[100],
                    //     child: const CardPoker(),
                    //   ),
                    //   Container(
                    //     padding: const EdgeInsets.all(4),
                    //     color: Colors.teal[200],
                    //     child: const CardPoker(),
                    //   ),
                    //   Container(
                    //     padding: const EdgeInsets.all(4),
                    //     color: Colors.teal[300],
                    //     child: const CardPoker(),
                    //   ),
                    //   Container(
                    //     padding: const EdgeInsets.all(4),
                    //     color: Colors.teal[400],
                    //     child: const CardPoker(),
                    //   ),
                    //   Container(
                    //     padding: const EdgeInsets.all(4),
                    //     color: Colors.teal[500],
                    //     child: const CardPoker(),
                    //   ),
                    //   Container(
                    //     padding: const EdgeInsets.all(4),
                    //     color: Colors.teal[600],
                    //     child: const CardPoker(),
                    //   ),
                    //   Container(
                    //     padding: const EdgeInsets.all(4),
                    //     color: Colors.teal[100],
                    //     child: const CardPoker(),
                    //   ),
                    //   Container(
                    //     padding: const EdgeInsets.all(4),
                    //     color: Colors.teal[200],
                    //     child: const CardPoker(),
                    //   ),
                    //   Container(
                    //     padding: const EdgeInsets.all(4),
                    //     color: Colors.teal[300],
                    //     child: const CardPoker(),
                    //   ),
                    //   Container(
                    //     padding: const EdgeInsets.all(4),
                    //     color: Colors.teal[400],
                    //     child: const CardPoker(),
                    //   ),
                    //   Container(
                    //     padding: const EdgeInsets.all(4),
                    //     color: Colors.teal[500],
                    //     child: const CardPoker(),
                    //   ),
                    //   Container(
                    //     padding: const EdgeInsets.all(4),
                    //     color: Colors.teal[600],
                    //     child: const CardPoker(),
                    //   ),
                    // ],
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    height: 40,
                    width: 150,
                    customFontSize: 15,
                    buttonText: 'Iniciar Juego', 
                    icon: Icons.play_arrow, 
                    onPressed: _countdownController.start,
                    color: const Color.fromARGB(255, 39,175,97),
                  ),
                  CustomButton(
                    height: 40,
                    width: 150,
                    customFontSize: 15,
                    buttonText: 'Jugar de nuevo', 
                    icon: Icons.play_arrow_outlined, 
                    onPressed: _countdownController.restart,
                    color: const Color.fromARGB(255, 39,175,97),
                  ),
                  
                ],
              ),
              const SizedBox(height: 20,),
              CustomButton(
                height: 40,
                width: 100,
                customFontSize: 15,
                buttonText: 'Salir', 
                icon: Icons.exit_to_app, 
                color: const Color.fromARGB(255, 239,40,75),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}