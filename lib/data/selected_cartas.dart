class SelectedCartas {
  static int cartasSeleccionada (String nombre){
    final nombres = <String>[];
    var puntos=0;
    if(nombres.length == 2){
      nombres.clear();
    }else{
      nombres.add(nombre);
      puntos = 0;
      if(nombres.length == 1){
        return 0;
      }else{
        if(nombres[0] == nombres[1]){
          puntos = 20;
        }
      }
      
    }
    return puntos;
  }
}
