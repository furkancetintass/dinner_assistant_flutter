// To parse this JSON data, do
//
//     final recipesModel = recipesModelFromJson(jsonString);

import 'dart:convert';

UserRecipesModel recipesModelFromJson(String str) =>
    UserRecipesModel.fromJson(json.decode(str));

String recipesModelToJson(UserRecipesModel data) => json.encode(data.toJson());

class UserRecipesModel {
  UserRecipesModel(
      {required this.making,
      required this.requirements,
      required this.title,
      required this.type});

  String making;
  String requirements;
  String title;
  String type;

  factory UserRecipesModel.fromJson(Map<dynamic, dynamic> json) =>
      UserRecipesModel(
          making: json["making"],
          requirements: json["requirements"],
          title: json["title"],
          type: json["type"]);

  Map<String, dynamic> toJson() => {
        "making": making,
        "requirements": requirements,
        "title": title,
      };
}
