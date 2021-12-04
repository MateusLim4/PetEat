import 'package:flutter/material.dart';
import 'package:peteat/shared/widgets/charts_interface/display.dart';

class YesterdayChart extends StatefulWidget {
  final List lista;
  final List consumido;
  YesterdayChart({Key? key, required this.lista, required this.consumido})
      : super(key: key);

  @override
  State<YesterdayChart> createState() => _YesterdayChartState();
}

class _YesterdayChartState extends State<YesterdayChart> {
  int valor = 0;
  int c = 0;

  @override
  Widget build(BuildContext context) {
    int now = DateTime.now().weekday - 2;
    switch (now) {
      case -2:
        now = 6;
        break;
      case -1:
        now = 1;
        break;
    }
    valor = widget.lista[now];
    if (widget.consumido.length >= now) {
      c = widget.consumido[now];
    }

    return ChartDisplay(
      quantConsumida: c,
      quantDefinida: valor,
    );
  }
}
