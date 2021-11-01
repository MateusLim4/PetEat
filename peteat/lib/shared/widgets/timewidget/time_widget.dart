import 'package:flutter/material.dart';
import 'package:peteat/shared/models/hour_model.dart';

import 'package:peteat/shared/themes/app_colors.dart';
import 'package:peteat/shared/themes/app_text_style.dart';

class TimeWidget extends StatelessWidget {
  final HourModel data;
  const TimeWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        height: size.height * 0.15,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.titleWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.hora!,
                    style: TextStyles.textBlack,
                  ),
                  Row(
                    children: [
                      TextButton(
                        child: const Text('Alterar',
                            style: TextStyle(color: AppColors.secondary)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/changeTime');
                        },
                      ),
                      TextButton(
                        child: const Text('Excluir',
                            style: TextStyle(color: AppColors.buttonRed)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                data.semana!,
                style: TextStyles.textBlackLight,
              ),
            ],
          ),
        ));
  }
}
