class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  bool favorites = false;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  // Создание объекта из JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['ID'],
      name: json['Name'],
      price: json['Price'].toDouble(),
      imageUrl: json['ImageURL'],
      description: json['Description'],
    );
  }

// Преобразование объекта в JSON
// Map<String, dynamic> toJson() {
//   return {
//     'ID': id,
//     'Name': name,
//     'Price': price,
//     'ImageURL': imageUrl,
//     'Description': description,
//   };
// }
}