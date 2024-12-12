import 'package:flutter/material.dart';

class ProductDeletionDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ProductDeletionDialog({Key? key, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Удалить продукт'),
      content: Text('Вы уверены?'),
      actions: <Widget>[
        TextButton(
          child: Text('Отмена'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        TextButton(
          child: Text('Подтвердить'),
          onPressed: () {
            onConfirm();
          },
        ),
      ],
    );
  }
}