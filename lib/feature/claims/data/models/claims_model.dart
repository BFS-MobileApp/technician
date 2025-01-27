// To parse this JSON data, do
//
//     final claimsModel = claimsModelFromJson(jsonString);

import 'dart:convert';

ClaimsModel claimsModelFromJson(String str) => ClaimsModel.fromJson(json.decode(str));

String claimsModelToJson(ClaimsModel data) => json.encode(data.toJson());

class ClaimsModel {
  List<Datum> data;
  Meta meta;

  ClaimsModel({
    required this.data,
    required this.meta,
  });

  factory ClaimsModel.fromJson(Map<String, dynamic> json) => ClaimsModel(
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
  String referenceId;
  String status;
  String description;
  DateTime availableDate;
  String availableTime;
  dynamic employeeId;
  String startDate;
  String endDate;
  String createdBy;
  String priority;
  String createdAt;
  Unit unit;
  Category category;
  Category subCategory;
  Category type;

  Datum({
    required this.id,
    required this.referenceId,
    required this.status,
    required this.description,
    required this.availableDate,
    required this.availableTime,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.createdBy,
    required this.priority,
    required this.createdAt,
    required this.unit,
    required this.category,
    required this.subCategory,
    required this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    referenceId: json["reference_id"]??'',
    status: json["status"]??'',
    description: json["description"]??'',
    availableDate: DateTime.parse(json["available_date"]??''),
    availableTime: json["available_time"]??'',
    employeeId: json["employee_id"]??'',
    startDate: json["start_date"]??'',
    endDate: json["end_date"]??'',
    createdBy: json["created_by"]??'',
    priority: json["priority"]??'',
    createdAt: json["created_at"],
    unit: Unit.fromJson(json["unit"]),
    category: Category.fromJson(json["category"]),
    subCategory: Category.fromJson(json["subCategory"]),
    type: Category.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference_id": referenceId,
    "status": status,
    "description": description,
    "available_date": "${availableDate.year.toString().padLeft(4, '0')}-${availableDate.month.toString().padLeft(2, '0')}-${availableDate.day.toString().padLeft(2, '0')}",
    "available_time": availableTime,
    "employee_id": employeeId,
    "start_date": startDate,
    "end_date": endDate,
    "created_by": createdBy,
    "priority": priority,
    "created_at": createdAt,
    "unit": unit.toJson(),
    "category": category.toJson(),
    "subCategory": subCategory.toJson(),
    "type": type.toJson(),
  };
}


class Category {
  int id;
  String code;
  String name;
  String? estimationTime;

  Category({
    required this.id,
    required this.code,
    required this.name,
    this.estimationTime,

  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    code: json["code"]??'',
    name: json["name"]??'',
    estimationTime: json["estimation_time"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "estimation_time": estimationTime,
  };
}


class Unit {
  int id;
  String code;
  String name;
  String type;
  String building;
  String startAt;
  String endAt;

  Unit({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
    required this.building,
    required this.startAt,
    required this.endAt,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    code: json["code"]??'',
    name: json["name"]??'',
    type: json["type"]??'',
    building: json["building"]??'',
    startAt: json["start_at"]??'',
    endAt: json["end_at"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "type": type,
    "building": building,
    "start_at": startAt,
    "end_at": endAt,
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
  String next;

  Links({
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    next: json["next"]??'',
  );

  Map<String, dynamic> toJson() => {
    "next": next,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
