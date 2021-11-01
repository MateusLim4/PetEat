import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peteat/shared/themes/app_colors.dart';

class GraficoDia extends StatefulWidget {
  const GraficoDia({Key? key}) : super(key: key);

  @override
  State<GraficoDia> createState() => _GraficoDiaState();
}

class _GraficoDiaState extends State<GraficoDia> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
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
    );
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
                return 'refeição 01';
              case 1:
                return 'refeição 02';
              case 2:
                return 'refeição 03';
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
                width: 15),
            BarChartRodData(
                y: 10, colors: [AppColors.grey, AppColors.grey], width: 15),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
                y: 15,
                colors: [AppColors.secondary, AppColors.secondary],
                width: 15),
            BarChartRodData(
                y: 10, colors: [AppColors.grey, AppColors.grey], width: 15),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
                y: 5,
                colors: [AppColors.secondary, AppColors.secondary],
                width: 15),
            BarChartRodData(
                y: 10, colors: [AppColors.grey, AppColors.grey], width: 15),
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
