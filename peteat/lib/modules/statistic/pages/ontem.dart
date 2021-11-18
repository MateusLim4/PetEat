import 'package:flutter/material.dart';
import 'package:peteat/functions/soma_quantidade.dart';
import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/widgets/charts_interface/display.dart';

class YesterdayChart extends StatefulWidget {
  YesterdayChart({Key? key}) : super(key: key);

  @override
  State<YesterdayChart> createState() => _YesterdayChartState();
}

class _YesterdayChartState extends State<YesterdayChart> {
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
    int now = DateTime.now().weekday - 2;
    List lista = somaQuantidade(configuracoes);
    switch (now) {
      case -1:
        now = 6;
        break;
      case 0:
        now = 1;
        break;
    }
    valor = lista[now];
    return ChartDisplay(
      quantConsumida: 0,
      quantDefinida: valor,
    );
  }
}
