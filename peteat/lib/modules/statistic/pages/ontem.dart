import 'package:flutter/material.dart';
import 'package:peteat/shared/widgets/charts_interface/display.dart';

class YesterdayChart extends StatefulWidget {
  final List lista;
  YesterdayChart({Key? key, required this.lista}) : super(key: key);

  @override
  State<YesterdayChart> createState() => _YesterdayChartState();
}

class _YesterdayChartState extends State<YesterdayChart> {
  int valor = 0;

  @override
  Widget build(BuildContext context) {
    int now = DateTime.now().weekday - 2;
    switch (now) {
      case -1:
        now = 6;
        break;
      case 0:
        now = 1;
        break;
    }
    valor = widget.lista[now];
    return ChartDisplay(
      quantConsumida: 0,
      quantDefinida: valor,
    );
  }
}
