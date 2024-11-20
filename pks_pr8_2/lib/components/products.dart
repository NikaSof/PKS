import 'package:flutter/material.dart';
import 'package:pks_pr8_2/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product item;
  const ProductCard(
      {
        super.key,
        required this.item
      }
      );

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      item.imageUrl,
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
                            item.name,
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            item.price.toStringAsFixed(item.price.truncateToDouble() == item.price ? 0 : 1) + " ₽",
                            style: TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                        ]
                    )
                ),
              ],
          ),
        ]
      )
    )
    );
  }
}