
import 'package:flutter/material.dart';
import 'package:juego_memoria/modules/game/view/game_page.dart';
import 'package:juego_memoria/widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35,40,72),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(            
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               const Text(
                'Juego de memoria', 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                  
                ),
              ),
              CustomButton(
                height: 50,
                width: 150,
                customFontSize: 20,
                buttonText: 'Iniciar Juego',
                icon: Icons.start_outlined,
                color: const Color.fromARGB(255, 39,175,97),
                onPressed: () async {
                  await Navigator.push(
                    context, 
                    MaterialPageRoute<void>(
                      builder: (context) => const GamePage(), 
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}