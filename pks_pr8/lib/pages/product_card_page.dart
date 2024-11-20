import 'package:flutter/material.dart';
import 'package:pks_pr8/models/product.dart';
import 'package:pks_pr8/services/api_service.dart';

class ProductPage extends StatefulWidget {
  final Future<Product> prodFuture;

  ProductPage({super.key, required this.prodFuture});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ApiService apiService = ApiService();
  bool isEditing = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  Future<void> updateKvas(Product item) async {
    try {
      final updatedItem = Product(
        id: item.id,
        price: double.tryParse(priceController.text) ?? 0.0,
        name: nameController.text,
        description: descriptionController.text,
        imageUrl: imageUrlController.text,
      );
      await apiService.updateProduct(updatedItem);
      Navigator.pop(context);
    } catch (e) {
      print('Error updating kvas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text("Страница отдельного кваса"),
        ),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: toggleEdit,
          ),
        ],
      ),
      body: FutureBuilder<Product>(
        future: widget.prodFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No product found'));
          }

          final item = snapshot.data!;

          if (isEditing) {
            nameController.text = item.name;
            descriptionController.text = item.description;
            imageUrlController.text = item.imageUrl;
          }


          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  bottom: 50,
                  right: 15,
                  left: 15,
                ),
                child: Column(
                  children: [
                    if (isEditing)
                      Column(
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: 'Название',
                            ),
                          ),
                          TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Описание',
                            ),
                          ),
                          TextField(
                            controller: imageUrlController,
                            decoration: const InputDecoration(
                              labelText: 'URL изображения',
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => updateKvas(item),
                            child: const Text('Сохранить'),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Image.network(item.imageUrl),
                          ),
                          Text(
                            item.description,
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final item = await widget.prodFuture;
          await apiService.deleteProduct(item.id);
          Navigator.pop(context);
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
