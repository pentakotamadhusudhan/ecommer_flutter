// To parse this JSON data, do
//
//     final customerDashBoardModel = customerDashBoardModelFromJson(jsonString);

import 'dart:convert';

CustomerDashBoardModel customerDashBoardModelFromJson(String str) => CustomerDashBoardModel.fromJson(json.decode(str));

String customerDashBoardModelToJson(CustomerDashBoardModel data) => json.encode(data.toJson());

class CustomerDashBoardModel {
  final List<Beauty>? chocolates;
  final List<Beauty>? toys;
  final List<Beauty>? electronics;
  final List<Beauty>? kitchen;
  final List<Beauty>? grains;
  final List<Beauty>? groceries;
  final List<Beauty>? snacks;
  final List<Beauty>? beauty;
  final List<Beauty>? clothings;

  CustomerDashBoardModel({
    this.chocolates,
    this.toys,
    this.electronics,
    this.kitchen,
    this.grains,
    this.groceries,
    this.snacks,
    this.beauty,
    this.clothings,
  });

  factory CustomerDashBoardModel.fromJson(Map<String, dynamic> json) => CustomerDashBoardModel(
    chocolates: json["chocolates"] == null ? [] : List<Beauty>.from(json["chocolates"]!.map((x) => Beauty.fromJson(x))),
    toys: json["toys"] == null ? [] : List<Beauty>.from(json["toys"]!.map((x) => Beauty.fromJson(x))),
    electronics: json["electronics"] == null ? [] : List<Beauty>.from(json["electronics"]!.map((x) => Beauty.fromJson(x))),
    kitchen: json["kitchen"] == null ? [] : List<Beauty>.from(json["kitchen"]!.map((x) => Beauty.fromJson(x))),
    grains: json["Grains"] == null ? [] : List<Beauty>.from(json["Grains"]!.map((x) => Beauty.fromJson(x))),
    groceries: json["Groceries"] == null ? [] : List<Beauty>.from(json["Groceries"]!.map((x) => Beauty.fromJson(x))),
    snacks: json["Snacks"] == null ? [] : List<Beauty>.from(json["Snacks"]!.map((x) => Beauty.fromJson(x))),
    beauty: json["Beauty"] == null ? [] : List<Beauty>.from(json["Beauty"]!.map((x) => Beauty.fromJson(x))),
    clothings: json["Clothings"] == null ? [] : List<Beauty>.from(json["Clothings"]!.map((x) => Beauty.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chocolates": chocolates == null ? [] : List<dynamic>.from(chocolates!.map((x) => x.toJson())),
    "toys": toys == null ? [] : List<dynamic>.from(toys!.map((x) => x.toJson())),
    "electronics": electronics == null ? [] : List<dynamic>.from(electronics!.map((x) => x.toJson())),
    "kitchen": kitchen == null ? [] : List<dynamic>.from(kitchen!.map((x) => x.toJson())),
    "Grains": grains == null ? [] : List<dynamic>.from(grains!.map((x) => x.toJson())),
    "Groceries": groceries == null ? [] : List<dynamic>.from(groceries!.map((x) => x.toJson())),
    "Snacks": snacks == null ? [] : List<dynamic>.from(snacks!.map((x) => x.toJson())),
    "Beauty": beauty == null ? [] : List<dynamic>.from(beauty!.map((x) => x.toJson())),
    "Clothings": clothings == null ? [] : List<dynamic>.from(clothings!.map((x) => x.toJson())),
  };
}

class Beauty {
  final int? id;
  final String? productName;
  final String? price;
  final String? productImage;
  final bool? vegFlag;
  final String? description;
  final int? categoryId;

  Beauty({
    this.id,
    this.productName,
    this.price,
    this.productImage,
    this.vegFlag,
    this.description,
    this.categoryId,
  });

  factory Beauty.fromJson(Map<String, dynamic> json) => Beauty(
    id: json["id"],
    productName: json["product_name"],
    price: json["price"],
    productImage: json["product_image"],
    vegFlag: json["veg_flag"],
    description: json["description"],
    categoryId: json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "price": price,
    "product_image": productImage,
    "veg_flag": vegFlag,
    "description": description,
    "category_id": categoryId,
  };
}
