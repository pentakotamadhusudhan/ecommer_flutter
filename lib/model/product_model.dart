// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

List<ProductsModel> productsModelFromJson(String str) => List<ProductsModel>.from(json.decode(str).map((x) => ProductsModel.fromJson(x)));

String productsModelToJson(List<ProductsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsModel {
  final int? id;
  final Store? store;
  final Product? product;
  final Category? category;
  final bool? isActive;
  final DateTime? createdAt;

  ProductsModel({
    this.id,
    this.store,
    this.product,
    this.category,
    this.isActive,
    this.createdAt,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    id: json["id"],
    store: json["store"] == null ? null : Store.fromJson(json["store"]),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store": store?.toJson(),
    "product": product?.toJson(),
    "category": category?.toJson(),
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
  };
}

class Category {
  final int? id;
  final String? categoryName;

  Category({
    this.id,
    this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
  };
}

class Product {
  final int? id;
  final String? productName;
  final String? price;
  final String? productImage;
  final bool? vegFlag;
  final String? description;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? category;
  final int? createdBy;

  Product({
    this.id,
    this.productName,
    this.price,
    this.productImage,
    this.vegFlag,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.createdBy,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    productName: json["product_name"],
    price: json["price"],
    productImage: json["product_image"],
    vegFlag: json["veg_flag"],
    description: json["description"],
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    category: json["category"],
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "price": price,
    "product_image": productImage,
    "veg_flag": vegFlag,
    "description": description,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "category": category,
    "created_by": createdBy,
  };
}

class Store {
  final int? id;
  final String? name;
  final String? description;
  final String? address;
  final bool? isActive;
  final DateTime? createdAt;
  final int? vendor;

  Store({
    this.id,
    this.name,
    this.description,
    this.address,
    this.isActive,
    this.createdAt,
    this.vendor,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    address: json["address"],
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    vendor: json["vendor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "address": address,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "vendor": vendor,
  };
}
