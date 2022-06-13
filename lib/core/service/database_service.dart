import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  final databaseReference = FirebaseDatabase.instance.reference();
  late SharedPreferences prefs;

  late String userId;

  DateTime dateTime = DateTime.now();

  Future<void> createUser(
      String email, String firstName, String lastName, String userId) async {
    databaseReference.child("users").child(userId).set({
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "platform": Platform.isAndroid ? "Android" : "IOS",
      "id": userId,
    });
  }

  Future<bool> createTask(
      String userId, String? title, String content, String type) async {
    String taskId =
        databaseReference.child("tasks").child(userId).child(type).push().key;
    try {
      await databaseReference
          .child("tasks")
          .child(userId)
          .child(type)
          .child(taskId)
          .set({"title": title, "content": content, "taskId": taskId});
      return true;
    } catch (e) {
      debugPrint('create task fonk hata');
      return false;
    }
  }

  Future<bool> createRecipe(
    String userId,
    String title,
    String making,
    String requirements,
    String type,
  ) async {
    String recipeId =
        databaseReference.child("user-recipes").child(userId).push().key;
    try {
      await databaseReference
          .child("user-recipes")
          .child(userId)
          .child(recipeId)
          .set({
        "title": title,
        "making": making,
        "requirements": requirements,
        "type": type,
        "recipeId": recipeId,
      });
      return true;
    } catch (e) {
      debugPrint('create recipe fonk hata');
      return false;
    }
  }

  Future<bool> deleteTask(String type, String taskId, String userId) async {
    try {
      await databaseReference
          .child("tasks")
          .child(userId)
          .child(type)
          .child(taskId)
          .remove();

      return true;
    } catch (e) {
      debugPrint('delete task fonk hata');
      return false;
    }
  }
}
