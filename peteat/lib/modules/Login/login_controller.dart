import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:peteat/modules/auth/auth_controller.dart';
import 'package:peteat/shared/models/user_model.dart';

class LoginController {
  final authController = AuthController();

  Future<void> googleSignIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = await _googleSignIn.signIn();

      final user =
          UserModel(name: response!.displayName!, photoURL: response.photoUrl);
      authController.SetUser(context, user);
      print(response);
    } catch (error) {
      print(error);
    }
  }
}
