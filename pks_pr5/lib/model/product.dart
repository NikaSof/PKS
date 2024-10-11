class Product {
  final String id;
  final String name;
  final String price;
  final String discountPrice;
  final String imageUrl;
  final List<String> description;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.discountPrice = '',
    required this.imageUrl,
    required this.description,
    this.isFavorite = false,
  });
}
