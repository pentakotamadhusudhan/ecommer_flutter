// To parse this JSON data, do
//
//     final trendingModel = trendingModelFromJson(jsonString);

import 'dart:convert';

List<TrendingModel> trendingModelFromJson(String str) => List<TrendingModel>.from(json.decode(str).map((x) => TrendingModel.fromJson(x)));

String trendingModelToJson(List<TrendingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrendingModel {
  final int? id;
  final String? title;
  final int? price;
  final String? description;
  final List<String>? images;
  final DateTime? creationAt;
  final DateTime? updatedAt;
  final Category? category;

  TrendingModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.images,
    this.creationAt,
    this.updatedAt,
    this.category,
  });

  factory TrendingModel.fromJson(Map<String, dynamic> json) => TrendingModel(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    description: json["description"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    creationAt: json["creationAt"] == null ? null : DateTime.parse(json["creationAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "creationAt": creationAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "category": category?.toJson(),
  };
}

class Category {
  final int? id;
  final Name? name;
  final String? image;
  final DateTime? creationAt;
  final DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.image,
    this.creationAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: nameValues.map[json["name"]]!,
    image: json["image"],
    creationAt: json["creationAt"] == null ? null : DateTime.parse(json["creationAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "image": image,
    "creationAt": creationAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

enum Name {
  CLOTHES,
  CLOTHING,
  ELECTRONICS,
  FURNITURE,
  MISCELLANEOUS,
  SHOES
}

final nameValues = EnumValues({
  "Clothes": Name.CLOTHES,
  "clothing": Name.CLOTHING,
  "Electronics": Name.ELECTRONICS,
  "Furniture": Name.FURNITURE,
  "Miscellaneous": Name.MISCELLANEOUS,
  "Shoes": Name.SHOES
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
