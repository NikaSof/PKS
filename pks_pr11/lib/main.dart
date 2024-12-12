import 'package:pks_pr11/api/api_service.dart';
import 'package:pks_pr11/api/cart_api.dart';
import 'package:pks_pr11/api/favorite_api.dart';
import 'package:pks_pr11/api/product_api.dart';
import 'package:pks_pr11/auth/auth_gate.dart';
import 'package:pks_pr11/cart_bloc/cart_event.dart';
import 'package:pks_pr11/favorite_bloc/favorite_event.dart';
import 'package:pks_pr11/product_bloc/product_bloc.dart';
import 'package:pks_pr11/product_bloc/product_deletion_bloc.dart';
import 'package:pks_pr11/product_bloc/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cart_bloc/cart_bloc.dart';
import 'favorite_bloc/favorite_bloc.dart';
import 'pages/cart_page.dart';
import 'pages/favorite_page.dart';
import 'pages/home_page.dart';
import 'cubit/navigation_cubit.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://hymoooqsykvgsmpdavod.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5bW9vb3FzeWt2Z3NtcGRhdm9kIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQwMjQ1OTksImV4cCI6MjA0OTYwMDU5OX0.wKAMWeLyRzu4mklWZbSoiRczTJlh-raCbb5LtykYlMw',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (context) => FavoriteBloc(
            favoriteApi: FavoriteApi(ApiService()))..add(LoadFavoritesEvent(0)),
        ),
        BlocProvider(create: (context) => CartBloc(cartApi: CartApi(ApiService()))..add(LoadCartEvent(0))
        ),
        BlocProvider(create: (context) => ProductBloc(
            productApi: ProductApi(ApiService()))..add(LoadProductsEvent()),
        ),
        BlocProvider(create: (context) => ProductDeletionBloc(
          productBloc: context.read<ProductBloc>(),
          favoriteBloc: context.read<FavoriteBloc>(),
          cartBloc: context.read<CartBloc>(),
        )),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(),
      FavoritePage(
        productApi: ProductApi(ApiService()),
      ),
      CartPage(
        productApi: ProductApi(ApiService()),
      ),
      AuthGate(),
    ];

    return BlocBuilder<NavigationCubit, int>(
      builder: (context, selectedIndex) {
        return Scaffold(
          body: _pages[selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
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
                label: 'Корзина',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Профиль',
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: const Color(0xFF504BFF),
            unselectedItemColor: Colors.grey,
            onTap: (index) => context.read<NavigationCubit>().setPage(index),
          ),
        );
      },
    );
  }
}