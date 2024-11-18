import 'product.dart';

class CartItem {
  final Product items;
  int count;

  CartItem( this.items, this.count );

  // Создание объекта из JSON
  // factory CartItem.fromJson(Map<String, dynamic> json) {
  //   return CartItem(
  //     json['count'],
  //     id: json['ID'],
  //     name: json['Name'],
  //     price: json['Price'].toDouble(),
  //     imageUrl: json['ImageURL'],
  //     description: json['Description'],
  //   );
  // }

  // // Преобразование объекта в JSON
  // Map<String, dynamic> toJson() {
  //   return {
  //     'ID': id,
  //     'Name': name,
  //     'Price': price,
  //     'ImageURL': imageUrl,
  //     'Description': description,
  //     'count': count,
  //   };
  // }
}

