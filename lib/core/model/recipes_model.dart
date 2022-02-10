// To parse this JSON data, do
//
//     final recipesModel = recipesModelFromJson(jsonString);

import 'dart:convert';

RecipesModel recipesModelFromJson(String str) => RecipesModel.fromJson(json.decode(str));

String recipesModelToJson(RecipesModel data) => json.encode(data.toJson());

class RecipesModel {
  RecipesModel(
      {required this.making,
      required this.requirements,
      required this.title,
      required this.imageUrl});

  String making;
  String requirements;
  String title;
  String imageUrl;

  factory RecipesModel.fromJson(Map<dynamic, dynamic> json) => RecipesModel(
      making: json["making"],
      requirements: json["requirements"],
      title: json["title"],
      imageUrl: json["imageUrl"]);

  Map<String, dynamic> toJson() => {
        "making": making,
        "requirements": requirements,
        "title": title,
      };
}
