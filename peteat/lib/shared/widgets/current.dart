import 'package:flutter/material.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';

class CurrentFood extends StatelessWidget {
  CurrentFood({Key? key}) : super(key: key);
  @override
  double percent = 0.95;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        children: [
          const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Quantidade no reservatório',
                textAlign: TextAlign.left,
              )),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.stroke,
                ),
                child: Text(''),
                width: size.width * 0.8,
                height: size.height * 0.05,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.secondary,
                ),
                child: Text(''),
                width: size.width * percent * 0.8,
                height: size.height * 0.05,
              ),
              Container(
                height: size.height * 0.05,
                child: Center(
                  child: Text('${percent * 100}%',
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
