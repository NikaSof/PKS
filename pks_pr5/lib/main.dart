import 'package:flutter/material.dart';
import 'package:pks_pr5/pages/home.dart';
import 'package:pks_pr5/pages/favorites.dart';
import 'package:pks_pr5/pages/profile.dart';
import 'package:pks_pr5/widgets/bottom_menu.dart';
import 'package:pks_pr5/model/product.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Polaroid Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Product> favoriteProducts = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFavorite(Product product) {
    setState(() {
      if (product.isFavorite) {
        favoriteProducts.add(product);
      } else {
        favoriteProducts.remove(product);
      }
    });
  }

  void _deleteProduct(Product product) {
    setState(() {
      favoriteProducts.remove(product);
      products.removeWhere((p) => p.id == product.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(_selectedIndex),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return HomeScreen(
            onFavoriteToggle: _toggleFavorite,
            onProductDelete: _deleteProduct,
        );
      case 1:
        return FavoriteScreen(
            favoriteProducts: favoriteProducts,
            onFavoriteToggle: _toggleFavorite,
            onProductDelete: _deleteProduct,
        );
      case 2:
        return ProfileScreen();
      default:
        return HomeScreen(
            onFavoriteToggle: _toggleFavorite,
            onProductDelete: _deleteProduct,
        );
    }
  }
}