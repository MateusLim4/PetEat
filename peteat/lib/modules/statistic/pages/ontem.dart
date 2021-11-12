import 'package:flutter/material.dart';
import 'package:peteat/shared/widgets/charts_interface/display.dart';

class YesterdayChart extends StatefulWidget {
  YesterdayChart({Key? key}) : super(key: key);

  @override
  State<YesterdayChart> createState() => _YesterdayChartState();
}

class _YesterdayChartState extends State<YesterdayChart> {
  @override
  Widget build(BuildContext context) {
    return const ChartDisplay(
      quantConsumida: 250,
      quantDefinida: 250,
    );
  }
}
