import 'package:flutter/material.dart';
import 'package:peteat/modules/auth/auth_controller.dart';
import 'package:peteat/share/presets/app_colors.dart';
import 'package:peteat/share/presets/app_text_style.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authController = AuthController();
    authController.currentUser(context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Center(
                  child: Image.asset('assets/images/pawprint.png',
                      width: size.width, height: size.height * 0.4),
                ),
              ),
              Center(
                child: Text('Peteat', style: TextStyles.titleHome),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
