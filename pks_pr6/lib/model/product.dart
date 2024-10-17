class Product {
  final num id;
  final String name;
  final double price;
  final double? discountPrice;
  final String imageUrl;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.discountPrice,
    required this.imageUrl,
    required this.description,
  });
}
