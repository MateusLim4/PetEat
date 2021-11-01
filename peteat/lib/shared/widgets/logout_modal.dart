import 'package:flutter/material.dart';
import 'package:peteat/shared/models/user_model.dart';

class Logout extends StatelessWidget {
  final UserModel user;
  const Logout({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: NetworkImage(user.photoURL!),
          ),
        ),
      ),
    );
  }
}
