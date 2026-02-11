// To parse this JSON data, do
//
//     final storesModel = storesModelFromJson(jsonString);

import 'dart:convert';

List<StoresModel> storesModelFromJson(String str) => List<StoresModel>.from(json.decode(str).map((x) => StoresModel.fromJson(x)));

String storesModelToJson(List<StoresModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoresModel {
  final int? id;
  final int? vendor;
  final String? name;
  final String? description;
  final String? address;
  final bool? isActive;
  final DateTime? createdAt;

  StoresModel({
    this.id,
    this.vendor,
    this.name,
    this.description,
    this.address,
    this.isActive,
    this.createdAt,
  });

  factory StoresModel.fromJson(Map<String, dynamic> json) => StoresModel(
    id: json["id"],
    vendor: json["vendor"],
    name: json["name"],
    description: json["description"],
    address: json["address"],
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor": vendor,
    "name": name,
    "description": description,
    "address": address,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
  };
}
