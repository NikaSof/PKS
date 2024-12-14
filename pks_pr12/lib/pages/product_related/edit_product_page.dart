import 'package:pks_pr11/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../product_bloc/product_bloc.dart';
import '../../product_bloc/product_event.dart';
import '../../product_bloc/product_state.dart';


class EditProductPage extends StatefulWidget {
  final int productId;

  EditProductPage({required this.productId});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController _controllerName;
  late TextEditingController _controllerImage;
  late TextEditingController _controllerDescription;
  late TextEditingController _controllerPrice;
  late TextEditingController _controllerStock;

  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController();
    _controllerImage = TextEditingController();
    _controllerDescription = TextEditingController();
    _controllerPrice = TextEditingController();
    _controllerStock = TextEditingController();

    // Find the product in the current state
    final currentState = context.read<ProductBloc>().state;
    if (currentState.status == ProductStatus.success) {
      final product = currentState.products.firstWhere(
            (p) => p.productId == widget.productId,
        orElse: () => throw Exception('Product not found'),
      );
      _populateFields(product);
    }
  }

  void _populateFields(Product product) {
    _controllerName.text = product.name;
    _controllerImage.text = product.imageUrl;
    _controllerDescription.text = product.description;
    _controllerPrice.text = product.price.toString();
    _controllerStock.text = product.stock.toString();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerImage.dispose();
    _controllerDescription.dispose();
    _controllerPrice.dispose();
    _controllerStock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать товар'),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state.status == ProductStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Товар успешно обновлен')),
            );
            Navigator.pop(context);
          } else if (state.status == ProductStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Ошибка: ${state.errorMessage}')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == ProductStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _controllerName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Название',
                          hintText: 'Введите название...',
                        ),
                        maxLines: 1
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _controllerImage,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Изображение',
                          hintText: 'Введите URL изображения...',
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _controllerDescription,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Описание',
                          hintText: 'Введите описание...',
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _controllerPrice,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Стоимость',
                            hintText: 'Введите стоимость...'
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _controllerStock,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Количество',
                            hintText: 'Введите количество...'
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ProductBloc>().add(
                          EditProductEvent(
                              productId: widget.productId,
                              name: _controllerName.text,
                              imageUrl: _controllerImage.text,
                              description: _controllerDescription.text,
                              price: int.parse(_controllerPrice.text),
                              stock: int.parse(_controllerStock.text)
                          )
                      );
                    },
                    child: const Text('Сохранить'),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}