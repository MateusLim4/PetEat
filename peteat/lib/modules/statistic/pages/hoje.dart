import 'package:flutter/material.dart';
import 'package:peteat/functions/soma_quantidade.dart';
import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/widgets/charts_interface/display.dart';

class TodayChart extends StatefulWidget {
  final List lista;
  TodayChart({Key? key, required this.lista}) : super(key: key);

  @override
  State<TodayChart> createState() => _TodayChartState();
}

class _TodayChartState extends State<TodayChart> {
  int valor = 0;

  @override
  Widget build(BuildContext context) {
    int now = DateTime.now().weekday - 1;

    valor = widget.lista[now];
    print(valor);
    return ChartDisplay(
      quantConsumida: 0,
      quantDefinida: valor,
    );
  }
}
