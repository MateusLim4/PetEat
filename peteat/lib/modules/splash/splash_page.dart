import 'package:flutter/material.dart';
import 'package:peteat/share/app_colors.dart';
import 'package:peteat/share/app_text_style.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: Image.asset('assets/images/pawprint.png',
                      width: 250, height: 400),
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
