// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  int status;
  Data data;

  HomeModel({
    required this.status,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Claims claims;
  ClaimColor claimColor;
  List<dynamic> aboutToExpireUnits;

  Data({
    required this.claims,
    required this.claimColor,
    required this.aboutToExpireUnits,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    claims: Claims.fromJson(json["claims"]),
    claimColor: ClaimColor.fromJson(json["claim_color"]),
    aboutToExpireUnits: List<dynamic>.from(json["aboutToExpireUnits"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "claims": claims.toJson(),
    "claim_color": claimColor.toJson(),
    "aboutToExpireUnits": List<dynamic>.from(aboutToExpireUnits.map((x) => x)),
  };
}

class ClaimColor {
  String claimColorNew;
  String assigned;
  String started;
  String completed;
  String closed;
  String cancelled;

  ClaimColor({
    required this.claimColorNew,
    required this.assigned,
    required this.started,
    required this.completed,
    required this.closed,
    required this.cancelled,
  });

  Map<String, String> toMap() {
    return {
      "new": claimColorNew,
      "assigned": assigned,
      "started": started,
      "completed": completed,
      "closed": closed,
      "cancelled": cancelled,
    };
  }

  factory ClaimColor.fromJson(Map<String, dynamic> json) => ClaimColor(
    claimColorNew: json["new"],
    assigned: json["assigned"],
    started: json["started"],
    completed: json["completed"],
    closed: json["closed"],
    cancelled: json["cancelled"],
  );

  Map<String, dynamic> toJson() => {
    "new": claimColorNew,
    "assigned": assigned,
    "started": started,
    "completed": completed,
    "closed": closed,
    "cancelled": cancelled,
  };
}

class Claims {
  int all;
  int claimsNew;
  int assigned;
  int inProgress;
  int completed;
  int closed;
  int cancelled;

  Claims({
    required this.all,
    required this.claimsNew,
    required this.assigned,
    required this.inProgress,
    required this.completed,
    required this.closed,
    required this.cancelled,
  });

  factory Claims.fromJson(Map<String, dynamic> json) => Claims(
    all: json["all"],
    claimsNew: json["new"],
    assigned: json["assigned"],
    inProgress: json["in_progress"],
    completed: json["completed"],
    closed: json["closed"],
    cancelled: json["cancelled"],
  );

  Map<String, dynamic> toJson() => {
    "all": all,
    "new": claimsNew,
    "assigned": assigned,
    "in_progress": inProgress,
    "completed": completed,
    "closed": closed,
    "cancelled": cancelled,
  };
}
