

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Providers
import 'providers/auth_provider.dart';
import 'providers/products_provider.dart';
import 'providers/cart_provider.dart';

// Screens
import 'screens/login_screen.dart';
import 'screens/products_screen.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CartProvider>(
          create: (_) => CartProvider(null),
          update: (_, auth, previousCart) =>
          previousCart!..update(auth.userId),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shopping Cart App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 2,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          initialRoute: auth.isAuthenticated ? '/products' : '/login',
          routes: {
            '/login': (ctx) => const LoginScreen(),
            '/products': (ctx) => const ProductsScreen(),
            '/cart': (ctx) => const CartScreen(),
          },
        ),
      ),
    );
  }
}

