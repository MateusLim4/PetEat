import 'package:flutter/material.dart';
import 'package:peteat/functions/soma_quantidade.dart';
import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/widgets/charts_interface/display.dart';

class WeekChart extends StatefulWidget {
  const WeekChart({Key? key}) : super(key: key);

  @override
  State<WeekChart> createState() => _WeekChartState();
}

class _WeekChartState extends State<WeekChart> {
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
    int soma = 0;
    List lista = somaQuantidade(configuracoes);

    for (var element in lista) {
      soma = element + soma;
    }

    return ChartDisplay(
      quantConsumida: 0,
      quantDefinida: soma,
    );
  }
}
