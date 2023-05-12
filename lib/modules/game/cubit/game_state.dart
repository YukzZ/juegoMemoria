part of 'game_cubit.dart';

@immutable
class GameState {
  const GameState({
    this.status = GameEstatus.none,
    this.lsCartas = const <CartasPost>[],
    this.selectCartas = const <String>[],
    this.cartasModel,
    this.puntaje = 0,
  });

  final GameEstatus status;
  final List<CartasPost> lsCartas;
  final List<String> selectCartas;
  final CartasModel? cartasModel;
  final int puntaje;

  GameState copyWith({
    GameEstatus? status,
    List<CartasPost>? lsCartas,
    List<String>? selectCartas,
    CartasModel? cartasModel,
    int? puntaje,
  }){
    return GameState(
      status: status ?? this.status,
      lsCartas: lsCartas ?? this.lsCartas,
      selectCartas: selectCartas ?? this.selectCartas,
      cartasModel: cartasModel ?? this.cartasModel,
      puntaje: puntaje ?? this.puntaje,
    );
  }

  List<Object> get props => [status];
}

abstract class MemoryGameEvent {}

class ResetGameEvent extends MemoryGameEvent {}

class SelectCardEvent extends MemoryGameEvent {

  SelectCardEvent(this.card);
  final String card;
}

class GameOverEvent extends MemoryGameEvent {}

enum GameEstatus { none, loading, succes, failure, }
