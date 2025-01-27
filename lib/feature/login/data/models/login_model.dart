import 'dart:convert';

import 'package:technician/feature/login/domain/entities/login.dart';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel extends Login{
  Data data;
  String message;

  LoginModel({
    required this.data,
    required this.message,
  }) : super(name: data.name, token: data.token , msg: message);

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    data: Data.fromJson(json["data"] ??{}),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  String name;
  int companyId;
  String token;

  Data({
    required this.name,
    required this.companyId,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"]??'',
    companyId: json["company_id"]??0,
    token: json["token"]??'',
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "company_id": companyId,
    "token": token,
  };
}
