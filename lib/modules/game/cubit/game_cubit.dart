import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juego_memoria/data/cartas.dart';
import 'package:juego_memoria/data/cartas_post.dart';
import 'package:juego_memoria/data/model/cartas_model.dart';


import 'package:juego_memoria/data/provider/cartas_provider.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const GameState());

  late List<CartasPost> _lsCartas;
  final List<String> _selectCard = [];
  int puntaje=0;

  Future<void> getAll({required BuildContext context}) async{
    emit(state.copyWith(status: GameEstatus.loading));


    try{
      await Future<void>.delayed(const Duration(seconds: 1));
      final List<CartasPost> cartas = [];
      final newCartas = cartasData.map(
        (cartas) => CartasModel.fromJson(cartas).toCartasPostEntity(),
      ).toList();
      cartas.addAll(newCartas);
      final cartasProvider = cartas;
      _lsCartas = cartasProvider;
      emit(state.copyWith(
        status: GameEstatus.succes,
        lsCartas: _lsCartas,
        ),
      );
    } catch (e){
      emit(state.copyWith(status: GameEstatus.failure));
    }
  }

  void selectedCard({
    required String card,
    required BuildContext context,
  }) {
    _selectCard.add(card);
    if(_selectCard.isNotEmpty){

        if (_selectCard.length < 2 && !_selectCard.contains(card)) {
          _selectCard.add(card);
          if (_selectCard.length == 2) {
            
            if (_selectCard[0] == _selectCard[1]) {
              puntaje++;
              emit(state.copyWith(puntaje: puntaje));
              // _lsCartas[_lsCartas.indexOf(_selectCard[0] as CartasModel)];
              // _lsCartas[_lsCartas.indexOf(_selectCard[1] as CartasModel)];
              _selectCard.clear();
              if (_lsCartas.every((card) => card == null)) {
                showGameOver(context: context);
                // emit(state.copyWith(gameOver: _gameOver));
              }
            } else {
              Future.delayed(const Duration(seconds: 2), () {
                _selectCard.clear();
                emit(state.copyWith(selectCartas: _selectCard));
              });
            }
            emit(state.copyWith(lsCartas: _lsCartas));
          } else {
            emit(state.copyWith(selectCartas: _selectCard));
          }
        }
      }
    }

  Future<void> showGameOver({required BuildContext context}) async {
    await showDialog<void>(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Juego terminado'),
          content: const Text('El juego se ha terminado'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

}
