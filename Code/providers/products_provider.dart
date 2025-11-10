
import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];
  bool _isLoading = false;
  String? _error;
  List<Product> get items => [..._items]; // Return copy để tránh modify trực tiếp
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get itemCount => _items.length;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _items = Product.getDummyProducts();
      _isLoading = false;
      notifyListeners(); // UI hiển thị danh sách sản phẩm

      debugPrint('✅ Loaded ${_items.length} products');
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners(); // UI hiển thị error
      debugPrint('❌ Error loading products: $e');
    }
  }

  Product? findById(String id) {
    try {
      return _items.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Product> searchProducts(String query) {
    if (query.isEmpty) return items;

    final lowerQuery = query.toLowerCase();
    return _items
        .where((product) =>
    product.title.toLowerCase().contains(lowerQuery) ||
        product.description.toLowerCase().contains(lowerQuery))
        .toList();
  }
  Future<void> refreshProducts() async {
    await fetchProducts();
  }
}
