// To parse this JSON data, do
//
//     final unitModel = unitModelFromJson(jsonString);

import 'dart:convert';

UnitModel unitModelFromJson(String str) => UnitModel.fromJson(json.decode(str));

String unitModelToJson(UnitModel data) => json.encode(data.toJson());

class UnitModel {
  List<Datum> data;
  Meta meta;

  UnitModel({
    required this.data,
    required this.meta,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
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
  String code;
  String name;
  String type;
  String company;
  int companyId;
  String building;
  String startAt;
  String endAt;
  bool available;
  dynamic requestId;
  String linkRequestStatus;

  Datum({
    required this.id,
    required this.code,
    required this.name,
    required this.type,
    required this.company,
    required this.companyId,
    required this.building,
    required this.startAt,
    required this.endAt,
    required this.available,
    required this.requestId,
    required this.linkRequestStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"]??0,
    code: json["code"]??'',
    name: json["name"]??'',
    type: json["type"] ??'',
    company: json["company"] ?? '',
    companyId: json["company_id"]??0,
    building: json["building"] ?? '',
    startAt: json["start_at"] ?? '',
    endAt: json["end_at"] ?? '',
    available: json["available"] ?? false,
    requestId: json["request_id"] ?? 0,
    linkRequestStatus: json["link_request_status"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "type": type,
    "company": company,
    "company_id": companyId,
    "building": building,
    "start_at": startAt,
    "end_at": endAt,
    "available": available,
    "request_id": requestId,
    "link_request_status": linkRequestStatus,
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
    total: json["total"]??0,
    count: json["count"]??0,
    perPage: json["per_page"]??0,
    currentPage: json["current_page"]??0,
    totalPages: json["total_pages"]??0,
    links: Links.fromJson(json["links"]??[]),
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
