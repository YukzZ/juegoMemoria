import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juego_memoria/data/cartas.dart';
import 'package:juego_memoria/data/cartas_post.dart';
import 'package:juego_memoria/data/model/cartas_model.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const GameState());

  late List<CartasPost> _lsCartas;
  final List<String> selectCard = [];
  final List<String> correctCards = [];
  final List<int> colors = [
    100,
    200,
    300,
    400,
    500,
    600,
    100,
    200,
    300,
    400,
    500,
    600,
  ];
  int puntaje=0;

  Future<void> getAll({required BuildContext context}) async{
    emit(state.copyWith(status: GameEstatus.loading));


    try{
      await Future<void>.delayed(const Duration(seconds: 1));
      final cartas = <CartasPost>[];
      final newCartas = cartasData.map(
        (cartas) => CartasModel.fromJson(cartas).toCartasPostEntity(),
      ).toList();
      cartas.addAll(newCartas);
      final cartasProvider = cartas;
      _lsCartas = cartasProvider;
      _lsCartas.shuffle();
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
        if(selectCard.length >= 2){
          emit(state.copyWith(status: GameEstatus.isSelecting));
        } 
        else if (selectCard.length < 2 ) {
          selectCard.add(card);
          if (selectCard.length == 2) {
            
            if (selectCard[0] == selectCard[1]) {
              
              puntaje++;
              correctCards.add(card);
              emit(state.copyWith(
                puntaje: puntaje,
                status: GameEstatus.succes,
              ),);
              
              selectCard.clear();
              if (puntaje == 6) {
                showGameOver(context: context);
                emit(state.copyWith(status: GameEstatus.finishGame));
                
              }
            } else {
              
              Future.delayed(const Duration(seconds: 2), () {
                
                selectCard.clear();
                emit(state.copyWith(
                  selectCartas: selectCard,
                  status: GameEstatus.incorrectCards,
                ),);
              });
            }
            emit(state.copyWith(lsCartas: _lsCartas));
          } else {
            emit(state.copyWith(
              selectCartas: selectCard,
              status: GameEstatus.none,
            ),);
          }
        
        }
        // if(selectCard.isEmpty ){
        //   emit(state.copyWith(status: GameEstatus.succes));
        // }
        
    }

  Future<void> newGame ()async{
    selectCard.clear();
    correctCards.clear();
    puntaje = 0;
    emit(state.copyWith(
        selectCartas: selectCard,
        puntaje: puntaje,
        status: GameEstatus.succes,
      ),
    );
  }

  Future<void> showGameOver({required BuildContext context}) async {
    await showDialog<void>(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text('Juego terminado'),
          content: Text(
            'El juego se ha terminado, tu puntuacion es de $puntaje',
          ),
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
