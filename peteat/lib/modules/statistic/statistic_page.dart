import 'package:flutter/material.dart';
import 'package:peteat/modules/statistic/pages/hoje.dart';
import 'package:peteat/modules/statistic/pages/ontem.dart';
import 'package:peteat/modules/statistic/pages/semana.dart';
import 'package:peteat/modules/statistic/statistic_page_controller.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';
import 'package:peteat/shared/widgets/charts/dounuts_chart.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final controller = StatisticsController();

  @override
  bool current1 = false;
  bool current2 = true;
  bool current3 = false;

  List pages = [TodayChart(), YesterdayChart(), WeekChart()];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final configController = StatisticsController();

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(152),
          child: Container(
            height: 152,
            color: AppColors.titleWhite,
            child: Center(
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BackButton(),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 25),
                            child: Text('Alimentador 01 ',
                                style: TextStyles.pinkTitle),
                          ),
                          TextButton(
                            child: const Icon(Icons.notifications,
                                size: 40, color: AppColors.grey),
                            onPressed: () {},
                          ),
                        ]),
                  ),
                ),
              ]),
            ),
          ),
        ),
        backgroundColor: AppColors.primary,
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: size.height * 0.5,
                        width: size.width * 0.85,
                        color: AppColors.titleWhite,
                        child: pages[controller.currentPage]),
                  ],
                ),
              ),
            ])),
        bottomNavigationBar: Container(
          height: 90,
          color: AppColors.titleWhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              newButton('ONTEM', current1, 1),
              newButton('HOJE', current2, 2),
              newButton('SEMANA', current3, 3),
            ],
          ),
        ));
  }

  Widget newButton(texto, ativo, index) {
    return ativo
        ? TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primary)),
            onPressed: () {},
            child: Text(texto, style: TextStyles.textWhiteBold),
          )
        : TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.titleWhite)),
            onPressed: () {
              setState(() {
                currentButton(index);
              });
              super.initState();
            },
            child: Text(texto, style: TextStyles.textGrey));
  }

  void currentButton(index) async {
    switch (index) {
      case (1):
        current1 = true;
        current2 = false;
        current3 = false;
        controller.setPage(1);
        break;
      case (2):
        current2 = true;
        current1 = false;
        current3 = false;
        controller.setPage(0);
        break;
      case (3):
        current3 = true;
        current1 = false;
        current2 = false;
        controller.setPage(2);
        break;
    }
  }
}
