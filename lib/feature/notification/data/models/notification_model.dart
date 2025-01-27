// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  String status;
  List<Datum> data;

  NotificationModel({
    required this.status,
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  DateTime date;
  String diffDate;
  List<Item> items;

  Datum({
    required this.date,
    required this.diffDate,
    required this.items,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: DateTime.parse(json["date"]),
    diffDate: json["diff_date"]??'',
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))??[]),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "diff_date": diffDate,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  String model;
  int modelId;
  String url;
  String title;

  Item({
    required this.model,
    required this.modelId,
    required this.url,
    required this.title,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    model: json["model"]??'',
    modelId: json["model_id"]??0,
    url: json["url"]??'',
    title: json["title"]??'',
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "model_id": modelId,
    "url": url,
    "title": title,
  };
}
