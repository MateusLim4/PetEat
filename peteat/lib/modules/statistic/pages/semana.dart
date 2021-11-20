import 'package:flutter/material.dart';
import 'package:peteat/shared/widgets/charts_interface/display.dart';

class WeekChart extends StatefulWidget {
  final List lista;
  const WeekChart({Key? key, required this.lista}) : super(key: key);

  @override
  State<WeekChart> createState() => _WeekChartState();
}

class _WeekChartState extends State<WeekChart> {
  int valor = 0;

  @override
  Widget build(BuildContext context) {
    int soma = 0;

    for (var element in widget.lista) {
      soma = element + soma;
    }

    return ChartDisplay(
      quantConsumida: 0,
      quantDefinida: soma,
    );
  }
}
