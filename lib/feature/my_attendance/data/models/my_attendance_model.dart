// To parse this JSON data, do
//
//     final myAttendanceModel = myAttendanceModelFromJson(jsonString);

import 'dart:convert';

MyAttendanceModel myAttendanceModelFromJson(String str) => MyAttendanceModel.fromJson(json.decode(str));

String myAttendanceModelToJson(MyAttendanceModel data) => json.encode(data.toJson());

class MyAttendanceModel {
  List<Datum> data;
  Meta meta;

  MyAttendanceModel({
    required this.data,
    required this.meta,
  });

  factory MyAttendanceModel.fromJson(Map<String, dynamic> json) => MyAttendanceModel(
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
  String clockInTime;
  String  clockOutTime;
  String note;
  CheckAddress? checkinAddress;
  CheckAddress? checkoutAddress;

  Datum({
    required this.id,
    required this.clockInTime,
    required this.clockOutTime,
    required this.note,
    required this.checkinAddress,
    required this.checkoutAddress,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    clockInTime: json["clock_in_time"] ?? '',
    clockOutTime: json["clock_out_time"] ?? '',
    note: json["note"]??'',
    checkinAddress: json["checkin_address"] == null ? null : CheckAddress.fromJson(json["checkin_address"]),
    checkoutAddress: json["checkout_address"] == null ? null : CheckAddress.fromJson(json["checkout_address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clock_in_time": clockInTime,
    "clock_out_time": clockOutTime,
    "note": note,
    "checkin_address": checkinAddress?.toJson(),
    "checkout_address": checkoutAddress?.toJson(),
  };
}

class CheckAddress {
  String latitude;
  String longitude;

  CheckAddress({
    required this.latitude,
    required this.longitude,
  });

  factory CheckAddress.fromJson(Map<String, dynamic> json) => CheckAddress(
    latitude: json["latitude"]??'',
    longitude: json["longitude"]??'',
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
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
