import 'package:flutter/material.dart';
import 'package:peteat/shared/widgets/charts_interface/display.dart';

class WeekChart extends StatefulWidget {
  const WeekChart({Key? key}) : super(key: key);

  @override
  State<WeekChart> createState() => _WeekChartState();
}

class _WeekChartState extends State<WeekChart> {
  @override
  Widget build(BuildContext context) {
    return const ChartDisplay(
      quantConsumida: 1250,
      quantDefinida: 1750,
    );
  }
}
