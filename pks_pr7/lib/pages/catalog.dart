import 'package:flutter/material.dart';
import 'package:pks_pr7/data/elements.dart';
import 'package:pks_pr7/models/product.dart';


class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  // void _handleAddToCart(ProductElement element) {
  //   // Implement your logic to add the product to the cart here
  //   print('Добавлен ${element.title}');
  // }

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 27, bottom: 30),
            child: Row(
              children: [
                Text('Каталог услуг',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 25.0, right:25.0),
                  child: ProductElementWidget(
                    data: data[index],
                    // onAddToCart: _handleAddToCart,
                  ),
                );
              },
          ),
          )
        ],
      )
    );
  }
}


