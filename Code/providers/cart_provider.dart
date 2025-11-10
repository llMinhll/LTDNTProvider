
import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};
  String? _userId;
  CartProvider(this._userId);
  void update(String? userId) {
    if (_userId != userId) {
      debugPrint('🔄 UserId changed: $_userId -> $userId');
      if (userId == null) {
        debugPrint('🧹 Clearing cart (user logged out)');
        _items.clear();
      }
      _userId = userId;
      notifyListeners();
    }
  }
  Map<String, CartItem> get items => {..._items};
  int get itemCount => _items.length;
  int get totalQuantity =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount =>
      _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool get isEmpty => _items.isEmpty;
  void addItem(Product product) {
    if (_userId == null) {
      debugPrint('⚠️ Cannot add to cart: User not logged in');
      return;
    }
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
            (existingItem) => existingItem.copyWith(
          quantity: existingItem.quantity + 1,
        ),
      );
      debugPrint('➕ Increased quantity: ${product.title}');
    } else {
      _items[product.id] = CartItem(
        id: DateTime.now().toString(),
        productId: product.id,
        title: product.title,
        price: product.price,
        quantity: 1,
      );
      debugPrint('🛒 Added to cart: ${product.title}');
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
    debugPrint('🗑️ Removed from cart: $productId');
  }
  void decreaseQuantity(String productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
            (existingItem) => existingItem.copyWith(
          quantity: existingItem.quantity - 1,
        ),
      );
      debugPrint('➖ Decreased quantity: $productId');
    } else {
      removeItem(productId);
    }
    notifyListeners();
  }
  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
            (existingItem) => existingItem.copyWith(
          quantity: existingItem.quantity + 1,
        ),
      );
      notifyListeners();
      debugPrint('➕ Increased quantity: $productId');
    }
  }

  void clear() {
    _items = {};
    notifyListeners();
    debugPrint('🧹 Cart cleared');
  }

  Future<void> checkout() async {
    if (isEmpty) return;

    debugPrint('💳 Processing checkout...');
    debugPrint('Total items: $totalQuantity');
    debugPrint('Total amount: ${totalAmount.toStringAsFixed(0)} VND');
    await Future.delayed(const Duration(seconds: 2));

    clear();
    debugPrint('✅ Checkout successful!');
  }
}
