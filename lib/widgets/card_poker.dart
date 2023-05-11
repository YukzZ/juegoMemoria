

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:juego_memoria/data/selected_cartas.dart';

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
  // String imgFront = 'assets/baraja/as_corazon.png';
  // https://www.pngegg.com/es/png-wvhco
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isSelected=!isSelected;
        SelectedCartas.cartasSeleccionada(widget.nombre);
        // widget.onPressed;
        // log('###########');
        setState(() {
          
        });
      },
      child: Image.asset(
        isSelected ? widget.imgFront : imgBack,
      )
    );
  }
}
