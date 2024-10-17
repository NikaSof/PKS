import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pks_pr6/data/products.dart';
import 'package:pks_pr6/model/cart_item.dart';
import 'package:pks_pr6/model/product.dart';
import 'package:pks_pr6/pages/product_card_page.dart';

class CardsListPage extends StatefulWidget {
  const CardsListPage({
    required this.favoriteProducts,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.removeCartItem
  });

  final Set<Product> favoriteProducts;
  final Function(Product) onFavoriteToggle;
  final Function(Product) onAddToCart;
  final Function(CartItem) removeCartItem;



  @override
  _CardsListPageState createState() => _CardsListPageState();
}

class _CardsListPageState extends State<CardsListPage> {
  List<Product> items = List.from(Products.products);

  void _navigateToAddCardScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCardScreen()),
    );

    if (result != null ) {
      setState(() {
        items.add(result);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(
          'Vintage Click',
          style: TextStyle(
            color: Colors.teal.shade900,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        ),
      ),
      body: items.isEmpty
          ? Center(child: Text(
        'Vintage Click',
        style: TextStyle(
          color: Colors.teal.shade900,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      )
      )
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.75,
        ),
        padding: const EdgeInsets.all(8.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return
            GestureDetector(
              onTap: () =>  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductPage(
                  item: items[index],
                  removeCartItem: widget.removeCartItem,
                  onAddToCart: (item) {
                    widget.onAddToCart(item);
                  },
                  favoriteProducts: widget.favoriteProducts,
                  onFavoriteToggle: (item) {
                    setState(() {
                      if(widget.favoriteProducts.contains(item)){
                        widget.favoriteProducts.remove(item);
                      } else {
                        widget.favoriteProducts.add(item);
                      }
                    });
                  },
                  onDelete: () {
                    setState(() {
                      widget.favoriteProducts.remove(items[index]);
                      items.removeAt(index);
                    });
                    Navigator.pop(context);
                  },
                )
                ),
              ),
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                            child: Image.network(
                              items[index].imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items[index].name,
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                // overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.0),
                              items[index].discountPrice != null
                                  ? Row(
                                children: [
                                  Text(
                                    items[index].price.toStringAsFixed(items[index].price.truncateToDouble() == items[index].price ? 0 : 1) + " " + "₽",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ) ,
                                  ),
                                  SizedBox(width: 8.0),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      '${items[index].discountPrice}'+ " ₽",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                                : Text(
                                items[index].price.toStringAsFixed(items[index].price.truncateToDouble() == items[index].price ? 0 : 1) + " " + "₽",
                                style: TextStyle(fontSize: 14.0, color: Colors.black),
                             ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            widget.onFavoriteToggle(items[index]);
                          });
                        },
                        icon: Icon(
                          widget.favoriteProducts.contains(items[index])
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.favoriteProducts.contains(items[index])
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    )
                  ],

                ),

              ),
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddCardScreen(context),
        child: Icon(Icons.add),
        tooltip: 'Добавить товар',
      ),
    );
  }
}

class AddCardScreen extends StatefulWidget {
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController _itemControllerTitle = TextEditingController();
  final TextEditingController _itemControllerDescription = TextEditingController();
  final TextEditingController _itemControllerPrice = TextEditingController();
  final TextEditingController _itemControllerImageURL = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить новый товар'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _itemControllerTitle,
              decoration: InputDecoration(
                labelText: 'Введите название',
              ),
              maxLines: 1,
            ),
            TextField(
              controller: _itemControllerDescription,
              decoration: InputDecoration(
                labelText: 'Введите описание',
              ),
              maxLines: 1,
            ),
            TextField(
              controller: _itemControllerPrice,
              decoration: InputDecoration(
                labelText: 'Введите цену',
              ),
              maxLines: 1,
            ),
            TextField(
              controller: _itemControllerImageURL,
              decoration: InputDecoration(
                labelText: 'Добавьте ссылку на картинку',
              ),
              maxLines: 1,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(_itemControllerImageURL.text.isNotEmpty && _itemControllerDescription.text.isNotEmpty && _itemControllerPrice.text.isNotEmpty && _itemControllerImageURL.text.isNotEmpty) {
                  Product newCard = Product(id: DateTime.now().millisecondsSinceEpoch, name: _itemControllerTitle.text, description: _itemControllerDescription.text,price: double.tryParse(_itemControllerPrice.text) ?? 0.0, imageUrl: _itemControllerImageURL.text);
                  Navigator.pop(context, newCard);
                }
              },
              child: Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}