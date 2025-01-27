// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class Datum {
  int id;
  String referenceId;
  String name;
  String icon;
  CategoryModel? child;

  Datum({
    required this.id,
    required this.referenceId,
    required this.name,
    required this.icon,
    this.child,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    referenceId: json["reference_id"],
    name: json["name"],
    icon: json["icon"],
    child: json["child"] == null ? null : CategoryModel.fromJson(json["child"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference_id": referenceId,
    "name": name,
    "icon": icon,
    "child": child?.toJson(),
  };
}

class CategoryModel {
  List<Datum> data;

  CategoryModel({
    required this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
