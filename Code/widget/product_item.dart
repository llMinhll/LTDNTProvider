
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (ctx, cart, child) {
        final cartItem = cart.items[product.id];
        final isInCart = cartItem != null;
        final quantity = cartItem?.quantity ?? 0;

        return Card(
          elevation: 2,
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hình ảnh sản phẩm
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4)),
                    child: Image.network(
                      product.imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (isInCart)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$quantity',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              // Thông tin sản phẩm
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    //const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product.price.toStringAsFixed(0)} đ',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        // Nút thêm vào giỏ
                        _buildAddButton(context),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildAddButton(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (ctx, auth, _) {
        if (!auth.isAuthenticated) {
          // Chưa đăng nhập -> hiển thị thông báo
          return IconButton(
            icon: const Icon(Icons.lock_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Vui lòng đăng nhập để thêm vào giỏ hàng!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          );
        }


        return IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            final cart = Provider.of<CartProvider>(context, listen: false);

            cart.addItem(product);

            // Hiển thị snackbar xác nhận
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Đã thêm ${product.title} vào giỏ hàng'),
                duration: const Duration(seconds: 1),
                action: SnackBarAction(
                  label: 'Xem giỏ hàng',
                  onPressed: () {
                    Navigator.of(context).pushNamed('/cart');
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
