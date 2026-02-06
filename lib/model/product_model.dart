// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

List<ProductsModel> productsModelFromJson(String str) => List<ProductsModel>.from(json.decode(str).map((x) => ProductsModel.fromJson(x)));

String productsModelToJson(List<ProductsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsModel {
  final int? id;
  final Category? category;
  final String? productName;
  final String? price;
  final String? productImage;
  final bool? vegFlag;
  final String? description;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? createdBy;

  ProductsModel({
    this.id,
    this.category,
    this.productName,
    this.price,
    this.productImage,
    this.vegFlag,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    id: json["id"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    productName: json["product_name"],
    price: json["price"],
    productImage: json["product_image"],
    vegFlag: json["veg_flag"],
    description: json["description"],
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category?.toJson(),
    "product_name": productName,
    "price": price,
    "product_image": productImage,
    "veg_flag": vegFlag,
    "description": description,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "created_by": createdBy,
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
