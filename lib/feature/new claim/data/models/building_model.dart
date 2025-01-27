// To parse this JSON data, do
//
//     final buildingModel = buildingModelFromJson(jsonString);

import 'dart:convert';

BuildingModel buildingModelFromJson(String str) => BuildingModel.fromJson(json.decode(str));

String buildingModelToJson(BuildingModel data) => json.encode(data.toJson());

class BuildingModel {
  List<Datum> data;
  Meta meta;

  BuildingModel({
    required this.data,
    required this.meta,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) => BuildingModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "meta": meta.toJson(),
  };
}

class Datum {
  int id;
  String refCode;
  String name;
  String company;
  String buildingCode;

  Datum({
    required this.id,
    required this.refCode,
    required this.name,
    required this.company,
    required this.buildingCode,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    refCode: json["ref_code"],
    name: json["name"],
    company: json["company"],
    buildingCode: json["building_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ref_code": refCode,
    "name": name,
    "company": company,
    "building_code": buildingCode,
  };
}

class Meta {
  Pagination pagination;

  Meta({
    required this.pagination,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination.toJson(),
  };
}

class Pagination {
  int total;
  int count;
  int perPage;
  int currentPage;
  int totalPages;
  Links links;

  Pagination({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    required this.links,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    count: json["count"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    totalPages: json["total_pages"],
    links: Links.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "count": count,
    "per_page": perPage,
    "current_page": currentPage,
    "total_pages": totalPages,
    "links": links.toJson(),
  };
}

class Links {
  Links();

  factory Links.fromJson(Map<String, dynamic> json) => Links(
  );

  Map<String, dynamic> toJson() => {
  };
}
