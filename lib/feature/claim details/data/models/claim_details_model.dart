// To parse this JSON data, do
//
//     final claimDetailsModel = claimDetailsModelFromJson(jsonString);

import 'dart:convert';

ClaimDetailsModel claimDetailsModelFromJson(String str) => ClaimDetailsModel.fromJson(json.decode(str));

String claimDetailsModelToJson(ClaimDetailsModel data) => json.encode(data.toJson());

class ClaimDetailsModel {
  Data data;

  ClaimDetailsModel({
    required this.data,
  });

  factory ClaimDetailsModel.fromJson(Map<String, dynamic> json) => ClaimDetailsModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
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
  DateTime createdAt;
  Unit unit;
  Category category;
  Category subCategory;
  Category type;
  List<FileElement> files;
  Comments comments;
  List<Employee> employees;

  List<Log> logs;
  List<Time> times;
  Creator creator;
  List<ClaimMaterials> material;

  Data({
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
    required this.files,
    required this.comments,
    required this.employees,
    required this.creator,
    required this.logs,
    required this.times,
    required this.material,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"]??0,
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
    createdAt: DateTime.parse(json["created_at"]??''),
    unit: Unit.fromJson(json["unit"]),
    category: Category.fromJson(json["category"]),
    subCategory: Category.fromJson(json["subCategory"]),
    type: Category.fromJson(json["type"]),
    files: List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x)) ?? []),
    comments: Comments.fromJson(json['comments']??[]),
    employees: json["employees"] is Map<String, dynamic>
        ? (json["employees"] as Map<String, dynamic>)
        .values
        .map((x) => Employee.fromJson(x))
        .toList()
        : List<Employee>.from(json["employees"].map((x) => Employee.fromJson(x))),
    creator: Creator.fromJson(json["creator"]),
    logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))??[]),
    times: List<Time>.from(json["times"].map((x) => Time.fromJson(x))??[]),
    material: List<ClaimMaterials>.from(json["materials"].map((x) => ClaimMaterials.fromJson(x))??[]),
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
    "created_at": createdAt.toIso8601String(),
    "unit": unit.toJson(),
    "category": category.toJson(),
    "subCategory": subCategory.toJson(),
    "type": type.toJson(),
    "files": List<dynamic>.from(files.map((x) => x.toJson())),
    "comments": comments.toJson(),
    "employees": employees.map((e) => e.toJson()).toList(),
    "creator": creator.toJson(),
    "logs": List<dynamic>.from(logs.map((x) => x.toJson())),
    "times": List<dynamic>.from(times.map((x) => x.toJson())),
  };
}



class TimeCreatedBy {
  int id;
  String name;
  String avatar;

  TimeCreatedBy({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory TimeCreatedBy.fromJson(Map<String, dynamic> json) => TimeCreatedBy(
    id: json["id"]??0,
    name: json["name"]??'',
    avatar: json["avatar"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
  };
}
class CreatedBy {
  int id;
  String name;

  CreatedBy({
    required this.id,
    required this.name,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["id"]??0,
    name: json["name"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Time {
  int id;
  String startOn;
  String endOn;
  TimeCreatedBy createdBy;

  Time({
    required this.id,
    required this.startOn,
    required this.endOn,
    required this.createdBy,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    id: json["id"]??0,
    startOn: json["start_on"]??'',
    endOn: json["end_on"]??'',
    createdBy: TimeCreatedBy.fromJson(json["created_by"]??''),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "start_on": startOn,
    "end_on": endOn,
    "created_by": createdBy.toJson(),
  };
}
class Log {
  String name;
  dynamic badge;
  String createdAt;
  dynamic reason;
  CreatedBy createdBy;

  Log({
    required this.name,
    required this.badge,
    required this.createdAt,
    required this.reason,
    required this.createdBy,
  });

  factory Log.fromJson(Map<String, dynamic> json) => Log(
    name: json["name"]??'',
    badge: json["badge"]??'',
    createdAt: json["created_at"]??'',
    reason: json["reason"]??'',
    createdBy: CreatedBy.fromJson(json["created_by"]??{}),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "badge": badge,
    "created_at": createdAt,
    "reason": reason,
    "created_by": createdBy.toJson(),
  };
}
class Employee {
  int id;
  String name;
  String imageUrl;
  String created_at;

  Employee({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.created_at
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    imageUrl: json["image_url"] ?? '',
    created_at: json["created_at"] ??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image_url": imageUrl,
    "created_at":created_at
  };
}
class ClaimMaterials {
  int id;
  int productId;
  int qty;
  String name;
  String code;
  String unit;
  String category;
  String group;
  String image;
  UserMat user;
  String createdAt;

  ClaimMaterials({
    required this.id,
    required this.productId,
    required this.qty,
    required this.name,
    required this.code,
    required this.image,
    required this.user,
    required this.createdAt,
    required this.unit,
    required this.group,
    required this.category,
  });

  factory ClaimMaterials.fromJson(Map<String, dynamic> json) => ClaimMaterials(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    image: json["image"] ?? '',
    createdAt: json["created_at"] ??'',
    productId: json["product_id"] ?? 0,
    qty: json["qty"] ?? 0,
    code: json["code"] ?? '',
    user: UserMat.fromJson(json["user"]??{}),
    unit: json["unit"] ?? '',
    group: json["group"] ?? '',
    category: json["category"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "productId":productId,
    "qty" : qty,
    "code" : code,
    "user" : user,
    "image": image,
    "created_at":createdAt
  };
}
class UserMat {
  int id;
  String avatar;
  String name;

  UserMat({
    required this.id,
    required this.avatar,
    required this.name,
  });

  factory UserMat.fromJson(Map<String, dynamic> json) => UserMat(
    id: json["id"]??0,
    avatar: json['avatar'] ?? "",
    name: json["name"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar" : avatar,
  };
}
class Category {
  int id;
  String code;
  String name;
  String estimationTime;

  Category({
    required this.id,
    required this.code,
    required this.name,
    required this.estimationTime,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"]??0,
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

class Creator {
  CreatorData data;

  Creator({
    required this.data,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    data: CreatorData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class CreatorData {
  int id;
  String refCode;
  String name;
  String email;
  String mobile;
  String avatar;

  CreatorData({
    required this.id,
    required this.refCode,
    required this.name,
    required this.email,
    required this.mobile,
    required this.avatar,
  });

  factory CreatorData.fromJson(Map<String, dynamic> json) => CreatorData(
    id: json["id"]??0,
    refCode: json["ref_code"]??'',
    name: json["name"]??'',
    email: json["email"]??'',
    mobile: json["mobile"]??'',
    avatar: json["avatar"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ref_code": refCode,
    "name": name,
    "email": email,
    "mobile": mobile,
    "avatar": avatar,
  };
}

class FileElement {
  int fileId;
  String fileName;
  String fileUrl;

  FileElement({
    required this.fileName,
    required this.fileUrl,
    required this.fileId });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
    fileName: json["file_name"]??'',
    fileUrl: json["file_url"]??'',
    fileId: json['file_id'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "file_name": fileName,
    "file_url": fileUrl,
    "file_id" : fileId,
  };
}

class Unit {
  int id;
  int companyId;
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
    required this.companyId,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"]??0,
    code: json["code"]??'',
    name: json["name"]??'',
    type: json["type"]??'',
    building: json["building"]??'',
    startAt: json["start_at"]??'',
    endAt: json["end_at"]??'',
    companyId: json["building_id"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "type": type,
    "building": building,
    "start_at": startAt,
    "end_at": endAt,
    "building_id" : companyId,
  };
}

class Comments {
  List<CommentsData> data;

  Comments({required this.data});

  Comments.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List<dynamic>)
      .map((e) => CommentsData.fromJson(e))
      .toList();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'data': data.map((v) => v.toJson()).toList(),
    };
  }
}

class CommentsData {
  int id;
  String comment;
  String createdAt;
  User user;
  List<dynamic>? files;

  CommentsData({
    required this.id,
    required this.comment,
    required this.createdAt,
    required this.user,
    required this.files
  });

  CommentsData.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        comment = json['comment'] ?? '',
        createdAt = json['created_at'] ?? '',
        files = json['files'] ?? [],
        user = User.fromJson(json['user']);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'comment': comment,
      'created_at': createdAt,
      'user': user.toJson(),
      'files':files
    };
  }
}

class User {
  UserData data;

  User({required this.data});

  User.fromJson(Map<String, dynamic> json)
      : data = UserData.fromJson(json['data']);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'data': data.toJson(),
    };
  }
}

class UserData {
  int id;
  String refCode;
  String name;
  String email;
  String avatar;

  UserData({
    required this.id,
    required this.refCode,
    required this.name,
    required this.email,
    required this.avatar,
  });

  UserData.fromJson(Map<String, dynamic> json) :
        id = json['id'] ??0,
        refCode = json['ref_code'] ??'',
        name = json['name']??'' ,
        email = json['email'] ??'' ,
        avatar = json['avatar'] ??'' ;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'ref_code': refCode,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }
}
