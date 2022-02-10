import 'package:dinner_assistant_flutter/core/api/api_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthInterface with ChangeNotifier {
  signUp(String email, String password);

  signIn(String email, String password);

  signOut();

  set userCredential(ApiResponse<UserCredential> value);

  ApiResponse<UserCredential> get userCredential;
}
