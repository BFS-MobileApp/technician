// To parse this JSON data, do
//
//     final technicianModel = technicianModelFromJson(jsonString);

import 'dart:convert';

TechnicianModel technicianModelFromJson(String str) => TechnicianModel.fromJson(json.decode(str));

String technicianModelToJson(TechnicianModel data) => json.encode(data.toJson());

class TechnicianModel {
  List<Datum> data;

  TechnicianModel({
    required this.data,
  });

  factory TechnicianModel.fromJson(Map<String, dynamic> json) => TechnicianModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  //String refCode;
  String name;
  String email;
  String avatar;

  Datum({
    required this.id,
    //required this.refCode,
    required this.name,
    required this.email,
    required this.avatar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"]??0,
    //refCode: json["ref_code"]??'',
    name: json["name"]??'',
    email: json["email"]??'',
    avatar: json["avatar"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    //"ref_code": refCode,
    "name": name,
    "email": email,
    "avatar": avatar,
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
