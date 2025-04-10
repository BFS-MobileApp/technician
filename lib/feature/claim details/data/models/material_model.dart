class MaterialResponse {
  List<Data> data;

  MaterialResponse({
    required this.data,
  });

  factory MaterialResponse.fromJson(Map<String, dynamic> json) => MaterialResponse(
    data: (json['data'] as List)
        .map((item) => Data.fromJson(item))
        .toList(),
  );

}
class Data {
  int id;
  int price;
  String name;
  String refCode;
  String image;
  String unit;
  String category;
  String group;

  Data({
    required this.id,
    required this.price,
    required this.name,
    required this.refCode,
    required this.image,
    required this.category,
    required this.group,
    required this.unit
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    image: json["image"] ?? '',
    price: (json["price"] is int)
        ? json["price"]
        : (json["price"] is double)
        ? (json["price"] as double).toInt()
        : int.tryParse(json["price"].toString()) ?? 0,
    refCode: json["code"] ?? '',
    category: json["category"] ?? '',
    group: json["group"] ?? '',
    unit: json["unit"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price" : price,
    "ref_code" : refCode,
    "category" : category,
    "group" : group,
    "unit" : unit,
    "code" : refCode,
    "image": image,
  };
}