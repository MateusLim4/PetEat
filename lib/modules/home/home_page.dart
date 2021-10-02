import 'package:flutter/material.dart';
import 'package:peteat/share/app_colors.dart';
import 'package:peteat/share/app_text_style.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.titleWhite,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                  text: 'Hello, ',
                  style: TextStyles.pinkTitleThin,
                  children: [
                    TextSpan(
                      text: "Mateus",
                      style: TextStyles.pinkTitle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.primary,
      body: Container(),
    );
  }
}
