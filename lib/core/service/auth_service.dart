import 'package:dinner_assistant_flutter/core/api/api_response.dart';
import 'package:dinner_assistant_flutter/core/interface/auth_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier implements AuthInterface {
  FirebaseAuth auth = FirebaseAuth.instance;

  ApiResponse<UserCredential> _userCredential = ApiResponse.initial('initial');

  @override
  set userCredential(ApiResponse<UserCredential> value) {
    _userCredential = value;
    notifyListeners();
  }

  @override
  ApiResponse<UserCredential> get userCredential => _userCredential;

  @override
  signUp(String email, String password) async {
    userCredential = ApiResponse.loading('');
    try {
      final result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      userCredential = ApiResponse.completed(result);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        userCredential = ApiResponse.error(e.toString());

        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        userCredential = ApiResponse.error(e.toString());

        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      userCredential = ApiResponse.error(e.toString());

      debugPrint(e.toString());
    }
  }

  @override
  signIn(String email, String password) async {
    userCredential = ApiResponse.loading('');
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      userCredential = ApiResponse.completed(result);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        userCredential = ApiResponse.error(e.toString());
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        userCredential = ApiResponse.error(e.toString());
        debugPrint('Wrong password provided for that user.');
      }
    }
  }

  @override
  signOut() async {
    await auth.signOut();
    _userCredential.data = null;
    userCredential = ApiResponse.initial('');
  }
}
// unit test