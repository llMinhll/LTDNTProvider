
class CartItem {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
  });

  double get totalPrice => price * quantity;

  CartItem copyWith({
    String? id,
    String? productId,
    String? title,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'title': title,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      productId: map['productId'] as String,
      title: map['title'] as String,
      price: (map['price'] as num).toDouble(),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() {
    return '''
    {
      "id": "$id",
      "productId": "$productId",
      "title": "$title",
      "price": $price,
      "quantity": $quantity
    }
    ''';
  }

  @override
  String toString() {
    return 'CartItem(id: $id, productId: $productId, title: $title, '
        'price: $price, quantity: $quantity, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem &&
        other.id == id &&
        other.productId == productId &&
        other.title == title &&
        other.price == price &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    productId.hashCode ^
    title.hashCode ^
    price.hashCode ^
    quantity.hashCode;
  }
}
