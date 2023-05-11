class CartasPost {

  CartasPost({
    required this.imageUrl,
    required this.name,
    this.id =0,
    this.color = 100,
  });

  final int id;
  final String name;
  final String imageUrl;
  final int color;
}
