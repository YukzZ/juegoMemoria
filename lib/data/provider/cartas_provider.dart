import 'package:flutter/material.dart';
import 'package:juego_memoria/data/cartas.dart';
import 'package:juego_memoria/data/cartas_post.dart';
import 'package:juego_memoria/data/model/cartas_model.dart';

class CartasProvider extends ChangeNotifier{
  bool initialLoading = true;
  List<CartasPost> cartas = [];

  Future<void> loadPage() async{
    await Future<void>.delayed(const Duration(seconds: 2));

    final newCartas = cartasData.map(
      (cartas) => CartasModel.fromJson(cartas).toCartasPostEntity(),
    ).toList();

    cartas.addAll(newCartas);
    initialLoading = false;
    notifyListeners();
  }
}
