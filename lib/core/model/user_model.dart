// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        required this.email,
        required this.firstName,
        required this.id,
        required this.lastName,
        required this.platform,
    });

    String email;
    String firstName;
    String id;
    String lastName;
    String platform;

    factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
        email: json["email"],
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
        platform: json["platform"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
        "platform": platform,
    };
}
