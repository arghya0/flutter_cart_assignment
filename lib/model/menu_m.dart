
// To parse this JSON data, do
//
//     final menuM = menuMFromJson(jsonString);

import 'dart:convert';

Map<String, List<MenuM>> menuMFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, List<MenuM>>(k, List<MenuM>.from(v.map((x) => MenuM.fromJson(x)))));

String menuMToJson(Map<String, List<MenuM>> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))));

class MenuM {
  MenuM({
    this.name,
    this.price,
    this.instock,
  });

  String name;
  int price;
  bool instock;

  factory MenuM.fromJson(Map<String, dynamic> json) => MenuM(
    name: json["name"],
    price: json["price"],
    instock: json["instock"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "instock": instock,
  };
}
