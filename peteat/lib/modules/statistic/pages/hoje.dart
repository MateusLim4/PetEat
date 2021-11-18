import 'package:flutter/material.dart';
import 'package:peteat/functions/soma_quantidade.dart';
import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/widgets/charts_interface/display.dart';

class TodayChart extends StatefulWidget {
  TodayChart({Key? key}) : super(key: key);

  @override
  State<TodayChart> createState() => _TodayChartState();
}

class _TodayChartState extends State<TodayChart> {
  late List<ConfigUser> configuracoes;
  bool isLoading = false;
  int valor = 0;

  @override
  void initState() {
    refreshConfigs();
    super.initState();
  }

  Future refreshConfigs() async {
    setState(() => isLoading = true);

    configuracoes = await AllConfigDatabase.instance.readAllConfigs();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    int now = DateTime.now().weekday - 1;
    List lista = somaQuantidade(configuracoes);
    valor = lista[now];
    return ChartDisplay(
      quantConsumida: 0,
      quantDefinida: valor,
    );
  }
}
