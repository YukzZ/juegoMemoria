
import 'dart:developer';

import 'package:flutter/material.dart';

class CardPoker extends StatefulWidget {
  const CardPoker({super.key, required this.imgFront});

  final String imgFront;

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
      child: Image.asset(
        isSelected ? widget.imgFront : imgBack,
      ),
      onTap: () {
        log('Se voltea carta');
        isSelected=!isSelected;
        setState(() {
          
        });
      },
    );
  }
}
