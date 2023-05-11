import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  List<String> _cards = [
    '🐶', '🐱', '🐭', '🐹', '🐰', '🦊', '🐻', '🐼',
    '🦁', '🐯', '🐮', '🐷', '🐸', '🐵', '🐔', '🐧'
  ];
  
  List<String> _selectedCards = [];
  int _attempts = 0;
  bool _gameOver = false;
  late Timer _timer;
  int _secondsElapsed = 0;
  
  @override
  void initState() {
    super.initState();
    _shuffleCards();
    _startTimer();
  }
  
  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
  
  void _shuffleCards() {
    final random = Random();
    for (var i = _cards.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final temp = _cards[i];
      _cards[i] = _cards[j];
      _cards[j] = temp;
    }
  }
  
  void _selectCard(String card) {
    if (_selectedCards.length == 2) return;
    if (_selectedCards.contains(card)) return;
    
    setState(() {
      _selectedCards.add(card);
    });
    
    if (_selectedCards.length == 2) {
      _attempts++;
      if (_selectedCards[0] == _selectedCards[1]) {
        _selectedCards.clear();
        if (_cards.every((card) => card == null)) {
          _stopTimer();
          _gameOver = true;
        }
      } else {
        _stopTimer();
        Timer(const Duration(seconds: 1), () {
          setState(() {
            _selectedCards.clear();
          });
          _startTimer();
        });
      }
    }
  }
  
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }
  
  void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }
  
  void _restartGame() {
    setState(() {
      _cards = [
        '🐶', '🐱', '🐭', '🐹', '🐰', '🦊', '🐻', '🐼',
        '🦁', '🐯', '🐮', '🐷', '🐸',
            ];
    _selectedCards = [];
    _attempts = 0;
    _gameOver = false;
    _secondsElapsed = 0;
    _stopTimer();
    _shuffleCards();
    _startTimer();
  });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego de memoria'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Intentos: $_attempts'),
            const SizedBox(height: 16),
            Text('Tiempo: $_secondsElapsed segundos'),
            const SizedBox(height: 32),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _cards.length,
              itemBuilder: (BuildContext context, int index) {
                if (_cards[index] == null) {
                  return Container();
                } else {
                  return GestureDetector(
                    onTap: () {
                      if (!_gameOver) {
                        setState(() {
                          _selectCard(_cards[index]);
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selectedCards.contains(_cards[index]) ? Colors.grey[300] : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          _selectedCards.contains(_cards[index]) ? _cards[index] : '',
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 32),
            if (_gameOver) TextButton(
              onPressed: _restartGame,
              child: const Text('¡Jugar de nuevo!'),
            ) else Container(),
          ],
        ),
      ),
    );
  }
}

