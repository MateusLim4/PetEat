import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:peteat/modules/models/user_model.dart';
import 'package:peteat/share/presets/app_colors.dart';
import 'package:peteat/share/presets/app_text_style.dart';
import 'package:peteat/share/widgets/my-globals.dart';
import 'package:peteat/share/widgets/time_widget.dart';

class Statistics extends StatefulWidget {
  final UserModel user;
  const Statistics({Key? key, required this.user}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final TextEditingController _controllerFood = TextEditingController();
  void quantAlimento() {
    if (_controllerFood.text != '') {
      food = _controllerFood.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                          IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, "/home",
                                    arguments: UserModel(
                                        name: widget.user.name,
                                        photoURL: widget.user.photoURL!));
                              }),
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
          child: Column(
            children: [
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Dia'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primary),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Semana'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.secondary),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Mês'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primary),
                      ),
                    ),
                  ),
                ],
              )),
              Container(
                width: size.width * 0.95,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.titleWhite,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: BarChart(
                    BarChartData(
                      barTouchData: barTouchData,
                      titlesData: titlesData,
                      borderData: borderData,
                      barGroups: barGroups,
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 2,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              const TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          margin: 20,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Mn';
              case 1:
                return 'Te';
              case 2:
                return 'Wd';
              case 3:
                return 'Tu';
              case 4:
                return 'Fr';
              case 5:
                return 'St';
              case 6:
                return 'Sn';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
                y: 10,
                colors: [AppColors.secondary, AppColors.secondary],
                width: 15)
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
                y: 10,
                colors: [AppColors.secondary, AppColors.secondary],
                width: 15)
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
                y: 5,
                colors: [AppColors.secondary, AppColors.secondary],
                width: 15)
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: 2,
                colors: [AppColors.secondary, AppColors.secondary],
                width: 15)
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
                y: 10,
                colors: [AppColors.secondary, AppColors.secondary],
                width: 15)
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
                y: 7,
                colors: [AppColors.secondary, AppColors.secondary],
                width: 15)
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
                y: 7,
                colors: [AppColors.secondary, AppColors.secondary],
                width: 15)
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
