import 'dart:convert';

import 'package:technician/feature/home/domain/entities/profile.dart';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel extends UserInfo{
  Data data;

  ProfileModel({
    required this.data,
  }) : super(id: data.id ,  email: data.email , image: data.avatar , mobile: data.profile.mobile , name: data.name , permissions: data.permissions , emailNotification: data.profile.emailNotifications,fcmToken: data.fcmToken,maxUploadFiles: data.maxUploadFiles);

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    data: Data.fromJson(json["data"]??{}),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  int id;
  String refCode;
  String name;
  String email;
  String avatar;
  Profile profile;
  List<String> permissions;
  String fcmToken;
  int maxUploadFiles;
  Data({
    required this.id,
    required this.refCode,
    required this.name,
    required this.email,
    required this.avatar,
    required this.profile,
    required this.permissions,
    required this.fcmToken,
    required this.maxUploadFiles
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"]??-1,
    refCode: json["ref_code"]??'',
    name: json["name"]??'',
    email: json["email"]??'',
    avatar: json["avatar"]??'',
    profile: Profile.fromJson(json["profile"]??{}),
    permissions: List<String>.from(json["permissions"].map((x) => x)),
      fcmToken: json["fcm_token"] ?? "",
      maxUploadFiles: json["max_upload_files"] ?? 0
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ref_code": refCode,
    "name": name,
    "email": email,
    "avatar": avatar,
    "profile": profile.toJson(),
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
    "fcm_token": fcmToken
  };
}

class Profile {
  String timezone;
  String mobile;
  String gender;
  String locale;
  String status;
  int emailNotifications;
  bool emailVerified;
  dynamic secondaryEmail;
  int secondaryEmailVerified;

  Profile({
    required this.timezone,
    required this.mobile,
    required this.gender,
    required this.locale,
    required this.status,
    required this.emailNotifications,
    required this.emailVerified,
    required this.secondaryEmail,
    required this.secondaryEmailVerified,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    timezone: json["timezone"]??'',
    mobile: json["mobile"]??'',
    gender: json["gender"]??'',
    locale: json["locale"]??'',
    status: json["status"]??'',
    emailNotifications: json["email_notifications"]??0,
    emailVerified: json["email_verified"]??false,
    secondaryEmail: json["secondary_email"],
    secondaryEmailVerified: json["secondary_email_verified"],
  );

  Map<String, dynamic> toJson() => {
    "timezone": timezone,
    "mobile": mobile,
    "gender": gender,
    "locale": locale,
    "status": status,
    "email_notifications": emailNotifications,
    "email_verified": emailVerified,
    "secondary_email": secondaryEmail,
    "secondary_email_verified": secondaryEmailVerified,
  };
}
