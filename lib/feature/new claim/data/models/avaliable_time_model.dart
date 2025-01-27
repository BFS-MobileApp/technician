// To parse this JSON data, do
//
//     final availableTimeModel = availableTimeModelFromJson(jsonString);

import 'dart:convert';

AvailableTimeModel availableTimeModelFromJson(String str) => AvailableTimeModel.fromJson(json.decode(str));

String availableTimeModelToJson(AvailableTimeModel data) => json.encode(data.toJson());

class AvailableTimeModel {
  List<Datum> data;

  AvailableTimeModel({
    required this.data,
  });

  factory AvailableTimeModel.fromJson(Map<String, dynamic> json) => AvailableTimeModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String referenceId;
  String name;

  Datum({
    required this.id,
    required this.referenceId,
    required this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"]??0,
    referenceId: json["reference_id"]??'',
    name: json["name"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference_id": referenceId,
    "name": name,
  };
}
