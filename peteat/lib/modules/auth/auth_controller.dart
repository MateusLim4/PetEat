import 'package:flutter/material.dart';
import 'package:peteat/shared/models/user_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  UserModel get user => _user!;

  // ignore: non_constant_identifier_names
  void SetUser(BuildContext context, UserModel? user) {
    if (user != null) {
      saveUser(user);
      _user = user;
      Navigator.pushReplacementNamed(context, "/home", arguments: user);
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();

    await instance.setString("user", user.toJson());
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;
      SetUser(context, UserModel.fromJson(json));
      return;
    } else {
      SetUser(context, null);
    }
  }
}
