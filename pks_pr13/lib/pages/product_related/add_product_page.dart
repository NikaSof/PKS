import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../product_bloc/product_bloc.dart';
import '../../product_bloc/product_event.dart';
import '../../product_bloc/product_state.dart';

class AddProductPage extends StatelessWidget {

  AddProductPage();

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerImage = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _controllerStock = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавьте новый товар"),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                maxLines: 1,
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                controller: _controllerPrice,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Стоимость',
                  hintText: 'Введите стоимость...',
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                controller: _controllerStock,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Количество',
                  hintText: 'Введите количество...',
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 32),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_controllerName.text.isNotEmpty &&
                          _controllerImage.text.isNotEmpty &&
                          _controllerDescription.text.isNotEmpty &&
                          _controllerPrice.text.isNotEmpty &&
                          _controllerStock.text.isNotEmpty) {
                        context.read<ProductBloc>().add(
                          AddProductEvent(
                            productId: DateTime.now().millisecondsSinceEpoch,
                            name: _controllerName.text,
                            imageUrl: _controllerImage.text,
                            description: _controllerDescription.text,
                            price: int.parse(_controllerPrice.text),
                            stock: int.parse(_controllerStock.text),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Сохранить'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );

  }
}