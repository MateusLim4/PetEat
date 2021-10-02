import 'package:flutter/material.dart';
import 'package:peteat/share/app_colors.dart';
import 'package:peteat/share/app_text_style.dart';
import 'package:peteat/share/widgets/social_button.dart';

import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = LoginController();
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
                width: size.width,
                height: size.height * 0.36,
                color: AppColors.titleWhite),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Positioned(
                  child: Image.asset('assets/images/dog.png',
                      height: 320, width: 550),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                  child: Text('Peteat', style: TextStyles.titleHome),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    top: 100,
                  ),
                  child: SocialLoginButton(
                    onTap: () {
                      controller.googleSignIn(context);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
