import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pks_pr8_2/models/product.dart';
import '../services/api_service.dart';

class AddCardPage extends StatefulWidget {
  final Function(Product) onNoteAdded;
  final List<Product> items;
  const AddCardPage({
    super.key,
    required this.onNoteAdded,
    required this.items
  });

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final TextEditingController Product_Controller_name = TextEditingController();
  final TextEditingController Product_Controller_price = TextEditingController();
  final TextEditingController Product_Controller_describe = TextEditingController();
  final TextEditingController Product_Controller_image = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text("Добавление"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: Product_Controller_name,
              decoration: const InputDecoration(
                labelText: 'Введи название',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Product_Controller_price,
              decoration: const InputDecoration(
                labelText: 'Введи цену',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Product_Controller_image,
              decoration: const InputDecoration(
                labelText: 'Введи ссылку на картинку',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Product_Controller_describe,
              decoration: const InputDecoration(
                labelText: 'Введи описание',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final String title = Product_Controller_name.text;
                final double price = double.tryParse(Product_Controller_price.text) ?? 0.0;
                final String text = Product_Controller_describe.text;
                final String imageUrl = Product_Controller_image.text;

                if (title.isNotEmpty &&
                    text.isNotEmpty &&
                    imageUrl.isNotEmpty) {
                  final Product newProduct = Product(
                    id: widget.items.isEmpty ? 1 : widget.items.last.id + 1,
                    name: title,
                    price: price,
                    description: text,
                    imageUrl: imageUrl,
                  );
                  await _apiService.addProductToServer(newProduct);
                  widget.onNoteAdded(newProduct);
                }
              },
              child: const Text('Добавить товар'),
            ),
          ],
        ),
      ),
    );
  }
}