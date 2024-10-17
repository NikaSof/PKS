import 'package:flutter/material.dart';
import 'package:pks_pr6/pages/cart.dart';
import 'package:pks_pr6/pages/home.dart';
import 'package:pks_pr6/pages/favorites.dart';
import 'package:pks_pr6/pages/profile.dart';
import 'package:pks_pr6/widgets/bottom_menu.dart';
import 'package:pks_pr6/model/product.dart';
import 'package:pks_pr6/model/cart_item.dart';


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
  final Set<Product> favoriteProducts = {};
  final Set<CartItem> cartItems = {};

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleFavorite(Product product){
    setState(() {
      if (favoriteProducts.contains(product)) {
        favoriteProducts.remove(product);
      } else {
        favoriteProducts.add(product);
      }
    });
  }

  void _addToCart(Product product){
    setState(() {

      bool itemExist = false;

      for(CartItem cartItem in cartItems){
        if(cartItem.id == product.id){
          cartItem.count += 1;
          itemExist = true;
          break;
        }
      }

      if (!itemExist) {
        cartItems.add(CartItem(1,
          id: product.id,
          name: product.name,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        ));
      }
    });
  }

  void _removeCartItem(CartItem cartItem){
    setState(() {
      cartItems.remove(cartItem);
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
        return CardsListPage(
          favoriteProducts: favoriteProducts,
          onFavoriteToggle: _toggleFavorite,
          onAddToCart: _addToCart,
          removeCartItem: _removeCartItem,
        );
      case 1:
        return FavoritePage(
          favoriteProducts: favoriteProducts,
          onFavoriteToggle: _toggleFavorite,
          onAddToCart: _addToCart,
          removeCartItem: _removeCartItem,
        );
      case 2:
        return CartPage(
            cartItems: cartItems,
            removeCartItem: _removeCartItem);
      case 3:
        return ProfilePage();
      default:
        return CardsListPage(
          favoriteProducts: favoriteProducts,
          onFavoriteToggle: _toggleFavorite,
          onAddToCart: _addToCart,
          removeCartItem: _removeCartItem,
        );
    }
  }
}