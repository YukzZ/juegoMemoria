

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juego_memoria/data/selected_cartas.dart';
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
        SelectedCartas.cartasSeleccionada(widget.nombre);
        context.read<GameCubit>().selectedCard(
          card: widget.nombre, 
          context: context,
        );
        // widget.onPressed;
        //  log('###########');
        setState(() {
          isSelected=!isSelected;
        });
      },
      child: Image.asset(
        isSelected ? widget.imgFront : imgBack,
      )
    );
  }
}
