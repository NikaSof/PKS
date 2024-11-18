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
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black26,
              width: 2
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(item.name,
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.19,
                child: Image.network(item.imageUrl
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}