import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onChanged;

  const SearchBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Поиск...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}