class Product {
  final int id;
  final String name;
  final String price;
  final String originalPrice;
  final int stock;
  final String brand;
  final int vendor;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.stock,
    required this.brand,
    required this.vendor,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      originalPrice: json['original_price'],
      stock: json['stock'],
      brand: json['brand'],
      vendor: json['vendor'],
    );
  }
}