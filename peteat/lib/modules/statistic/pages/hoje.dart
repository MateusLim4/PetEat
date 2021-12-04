import 'package:flutter/material.dart';

import 'package:peteat/shared/widgets/charts_interface/display.dart';

class TodayChart extends StatefulWidget {
  final List lista;
  final List consumido;
  TodayChart({Key? key, required this.lista, required this.consumido})
      : super(key: key);

  @override
  State<TodayChart> createState() => _TodayChartState();
}

class _TodayChartState extends State<TodayChart> {
  int valor = 0;
  int c = 0;

  @override
  Widget build(BuildContext context) {
    int now = DateTime.now().weekday - 1;

    valor = widget.lista[now];
    if (widget.consumido.length >= now) {
      c = widget.consumido[now];
    }

    return ChartDisplay(
      quantConsumida: 100,
      quantDefinida: 100,
    );
  }
}
