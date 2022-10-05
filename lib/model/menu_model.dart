
// To parse this JSON data, do
//
//     final menuModel = menuModelFromJson(jsonString);

import 'dart:convert';

List<MenuModel> menuModelFromJson(String str) => List<MenuModel>.from(json.decode(str).map((x) => MenuModel.fromJson(x)));

String menuModelToJson(List<MenuModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuModel {
  MenuModel({
    this.category,
    this.res,
  });

  String category;
  List<Re> res;

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
    category: json["category"],
    res: List<Re>.from(json["res"].map((x) => Re.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "res": List<dynamic>.from(res.map((x) => x.toJson())),
  };
}

class Re {
  Re({
    this.name,
    this.price,
    this.instock,
  });

  String name;
  int price;
  bool instock;

  factory Re.fromJson(Map<String, dynamic> json) => Re(
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
