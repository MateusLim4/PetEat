import 'package:flutter/material.dart';
import 'package:peteat/modules/auth/auth_controller.dart';
import 'package:peteat/shared/models/user_model.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatelessWidget {
  final UserModel user;
  const Logout({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Realmente deseja sair?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/images/crying.png')),
                  ),
                  Text(
                    'Pode ser que as suas configurações sejam perdidas',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancelar',
                    style: TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Desconectar',
                    style: TextStyle(
                        color: AppColors.buttonRed,
                        fontWeight: FontWeight.bold)),
                onPressed: () async {
                  final authController = AuthController();
                  Navigator.of(context).pop();
                  var instance = await SharedPreferences.getInstance();
                  instance.clear();
                  authController.SetUser(context, null);
                },
              ),
            ],
          );
        },
      );
    }

    return TextButton(
      onPressed: () async {
        _showMyDialog();
      },
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
