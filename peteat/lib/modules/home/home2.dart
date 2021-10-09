import 'package:flutter/material.dart';
import 'package:peteat/share/presets/app_colors.dart';
import 'package:peteat/share/presets/app_text_style.dart';

class FeederModal extends StatelessWidget {
  const FeederModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: Container(
          height: size.height * 0.35,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.titleWhite,
          ),
          child: Column(
            children: [
              Container(
                  height: size.height * 0.1,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: AppColors.secondary,
                  ),
                  child: Row(
                    children: [
                      Text('Alimentador 01', style: TextStyles.textWhite)
                    ],
                  ))
            ],
          )),
    );
  }
}
