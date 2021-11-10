import 'package:flutter/material.dart';
import 'package:peteat/functions/formata_hora.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';

class ConfigCardWidget extends StatelessWidget {
  ConfigCardWidget({Key? key, required this.config, required this.index});

  final ConfigUser config;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      color: AppColors.titleWhite,
      child: Container(
        constraints: BoxConstraints(minHeight: 50),
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${formataHora(config.hora, config.minuto)}',
                  style: TextStyles.blueText,
                ),
                Text('${config.alimento}g', style: TextStyles.pinkTitleThin)
              ],
            ),
            SizedBox(height: 4),
            Text('${config.diaSemana}', style: TextStyles.textBlackLight),
          ],
        ),
      ),
    );
  }
}
