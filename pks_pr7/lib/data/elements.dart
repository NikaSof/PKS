class ProductElement {
  final num id;
  final String title;
  final int price;
  final String term;
  bool isAdd = false;

  ProductElement({
    required this.id,
    required this.title,
    required this.price,
    required this.term,
  });
}

  List<ProductElement> data = [
    ProductElement(
        id: 1,
        title: 'ПРЦ-тест на определение РНК коронавируса стандартный',
        price: 1800,
        term: '2 дня'
    ),
    ProductElement(
        id: 2,
        title: 'Клинический анализ крови с лейкоцитарной формулировкой',
        price: 690,
        term: '1 день'
    ),
    ProductElement(
        id: 3,
        title: 'Биохимический анализ крови, базовый',
        price: 2440,
        term: '1 день'
    ),
  ];

class CartItem{
  final ProductElement item;
  int quantity;

  CartItem({
    required this.item,
    this.quantity = 1
  });
}

List<CartItem> cart = [];

// List<CartItem> cart = [];
