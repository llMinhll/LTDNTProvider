
class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  // Hàm tiện ích để tạo dummy data
  static List<Product> getDummyProducts() {
    return [
      Product(
        id: 'p1',
        title: 'iPhone 17',
        description: 'Điện thoại flagship mới nhất từ Apple',
        price: 29990000,
        imageUrl: 'http://cdn2.cellphones.com.vn/358x/media/catalog/product/i/p/iphone-17-pro-256-gb.png',
      ),
      Product(
        id: 'p2',
        title: 'Samsung Galaxy S24',
        description: 'Flagship Android cao cấp',
        price: 24990000,
        imageUrl: 'https://cdn.tgdd.vn/Products/Images/42/319665/samsung-galaxy-s24-256gb-5g-thumb-600x600.jpg',
      ),
      Product(
        id: 'p3',
        title: 'MacBook Pro M3',
        description: 'Laptop chuyên nghiệp cho developer',
        price: 45990000,
        imageUrl: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/laptop/macbook/macbook-pro-7.jpg',
      ),
      Product(
        id: 'p4',
        title: 'iPad Air',
        description: 'Máy tính bảng đa năng',
        price: 15990000,
        imageUrl: 'http://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/ipad-air-6-m2-11-inch_9__1_1_1.jpg',
      ),
      Product(
        id: 'p5',
        title: 'AirPods Pro',
        description: 'Tai nghe chống ồn cao cấp',
        price: 6990000,
        imageUrl: 'https://cdn.tgdd.vn/Products/Images/54/315014/tai-nghe-bluetooth-airpods-pro-2nd-gen-usb-c-charge-apple-1-750x500.jpg',
      ),
      Product(
        id: 'p6',
        title: 'Apple Watch Ultra',
        description: 'Đồng hồ thông minh bền bỉ',
        price: 21990000,
        imageUrl: 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/7077/314710/apple-watch-ultra-2-lte-49mm-vien-titanium-day-ocean-638641713635839632-750x500.jpg',
      ),
    ];
  }
}