


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juego_memoria/modules/game/cubit/game_cubit.dart';

class CardPoker extends StatefulWidget {
  const CardPoker({
    super.key, 
    required this.imgFront, 
    // required this.isSelected, 
    required this.onPressed,
    required this.nombre,
  });

  final String imgFront;
  final String nombre;
  // final bool isSelected;
  final VoidCallback onPressed;


  @override
  State<CardPoker> createState() => _CardPokerState();
}

class _CardPokerState extends State<CardPoker> {
  bool isSelected = false;
  String imgBack = 'assets/baraja/back.png';
  Widget childWidget = const CircularProgressIndicator();
  
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GameCubit>();
    if(cubit.state.status == GameEstatus.succes){
      isSelected = false;
        childWidget = Image.asset(
        isSelected ? widget.imgFront : imgBack,
      );
    }
    else if(cubit.state.status == GameEstatus.none){
      childWidget = Image.asset(
        isSelected ? widget.imgFront : imgBack,
      );
    }
     else if(cubit.state.status == GameEstatus.incorrectCards){
      isSelected = false;
      childWidget = Image.asset(
          imgBack,
        );
    }
    for(final i in cubit.correctCards){
      if(i == widget.nombre){
        childWidget = Image.asset(
          widget.imgFront,
        );
      }
    }
    return GestureDetector(
      onTap: () {
        cubit.selectedCard(
          card: widget.nombre, 
          context: context,
        );
        
        setState(() {
          isSelected=!isSelected;
          
        });
      },
      
      child: childWidget,
    );
  }
}
