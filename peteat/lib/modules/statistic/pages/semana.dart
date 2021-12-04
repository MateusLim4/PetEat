import 'package:flutter/material.dart';
import 'package:peteat/shared/widgets/charts_interface/display.dart';

class WeekChart extends StatefulWidget {
  final List lista;
  final List consumido;
  const WeekChart({Key? key, required this.lista, required this.consumido})
      : super(key: key);

  @override
  State<WeekChart> createState() => _WeekChartState();
}

class _WeekChartState extends State<WeekChart> {
  int valor = 0;
  int c = 0;

  @override
  Widget build(BuildContext context) {
    int soma = 0;
    int soma2 = 0;

    for (var element in widget.lista) {
      soma = element + soma;
    }

    for (var element in widget.consumido) {
      soma2 = element + soma2;
    }

    return ChartDisplay(
      quantConsumida: 100,
      quantDefinida: 200,
    );
  }
}
