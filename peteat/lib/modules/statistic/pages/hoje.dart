import 'package:flutter/material.dart';
import 'package:peteat/shared/widgets/charts_interface/display.dart';

class TodayChart extends StatefulWidget {
  TodayChart({Key? key}) : super(key: key);

  @override
  State<TodayChart> createState() => _TodayChartState();
}

class _TodayChartState extends State<TodayChart> {
  @override
  Widget build(BuildContext context) {
    return const ChartDisplay(
      quantConsumida: 250,
      quantDefinida: 1050,
    );
  }
}
