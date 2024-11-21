import 'package:flutter/material.dart';
import 'package:pks_pr8/pages/favorites.dart';
import 'pages/home.dart';
import 'pages/cart.dart';
import 'pages/profile.dart';
import 'models/product.dart';
import 'models/cart_item.dart';
import 'services/api_service.dart';

List<CartItem> carts = [];
List<Product> favorite = [];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late Future<List<Product>> _items;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _items = ApiService().getProducts();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _items,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return SingleChildScrollView(child: Center(child: Text('Error: ${snapshot.error}')));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(body: Center(child: Text('No products found', style:
          TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
          )
          ));
        }

        final items = snapshot.data!;

        return Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: [
              HomePage(products: items),
              FavoritesPage(),
              CartPage(),
              ProfilePage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Главная',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Избранное',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: "Корзина"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Профиль',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.grey[500],
            showUnselectedLabels: false,
            showSelectedLabels: false,
            iconSize: 32,
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
