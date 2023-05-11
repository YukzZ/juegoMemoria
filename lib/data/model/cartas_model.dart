import 'package:juego_memoria/data/cartas_post.dart';

class CartasModel {

  CartasModel({
    required this.imageUrl,
    required this.name,
    this.id = 0,
    this.color = 100,
  });

  factory CartasModel.fromJson(Map<String, dynamic> json) => 
    CartasModel(
      imageUrl: json['imageUrl'] as String, 
      name: json ['name'] as String,
      id: json['id'] as int,
      color: json['color'] as int,
    );

  final int id;
  final String name;
  final String imageUrl;
  final int color;

  CartasPost toCartasPostEntity() => CartasPost(
    imageUrl: imageUrl, 
    name: name,
    id: id,
    color: color,
  );
}
