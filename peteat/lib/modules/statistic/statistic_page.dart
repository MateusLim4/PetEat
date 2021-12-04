import 'package:flutter/material.dart';
import 'package:peteat/functions/soma_quantidade.dart';
import 'package:peteat/modules/statistic/pages/hoje.dart';
import 'package:peteat/modules/statistic/pages/ontem.dart';
import 'package:peteat/modules/statistic/pages/semana.dart';
import 'package:peteat/modules/statistic/statistic_page_controller.dart';
import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/models/consumido/consumido.dart';
import 'package:peteat/shared/models/consumido/consumido_db.dart';
import 'package:peteat/shared/mqtt/mqtt.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';

class Statistics extends StatefulWidget {
  final List lista;

  const Statistics({Key? key, required this.lista}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late List<ConfigUser> configuracoes;
  late List<QuantConsumida> consumo;
  bool isLoading = false;
  List consumido = [];

  @override
  void initState() {
    refreshConfigs();
    super.initState();
  }

  Future refreshConfigs() async {
    setState(() => isLoading = true);
    configuracoes = await AllConfigDatabase.instance.readAllConfigs();
    consumo = await QuantConsumidaDB.instance.readAllConfigs();
    configureAndConnect('DISPARO');
    getDados();
    setState(() => isLoading = false);
  }

  void getDados() async {
    var response = currentAppState.getHistoryText.split(' ');
    final isValid = response == [];
    if (isValid == false) {
      var ultimo;

      var now = DateTime.now().weekday;

      response = response[response.length - 1].split('A:');

      ultimo = double.tryParse(response[response.length - 1]);
      print(response);

      final consumoQuant =
          QuantConsumida(idDiaAtual: now, quantConsumida: ultimo / 100);

      if (response != []) {
        await QuantConsumidaDB.instance.create(consumoQuant);
      }
    }

    consumido = somaQuantidade2(consumo);
  }

  @override
  final controller = StatisticsController();

  late bool current1 = false;
  late bool current2 = true;
  late bool current3 = false;

  @override
  Widget build(BuildContext context) {
    List pages = [
      TodayChart(
        lista: widget.lista,
        consumido: consumido,
      ),
      YesterdayChart(
        lista: widget.lista,
        consumido: consumido,
      ),
      WeekChart(
        lista: widget.lista,
        consumido: consumido,
      )
    ];
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(152),
          child: Container(
            height: 152,
            color: AppColors.titleWhite,
            child: Center(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 160),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const BackButton(color: AppColors.primary),
                              Text('Graficos ', style: TextStyles.pinkTitle),
                            ]),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        backgroundColor: AppColors.primary,
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  isLoading
                      ? const CircularProgressIndicator()
                      : configuracoes.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Image.asset(
                                        'assets/images/detective.png')),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text('Não há nada para ver aqui!',
                                      style: TextStyles.textWhiteBold),
                                ),
                              ],
                            )
                          : Container(child: pages[controller.currentPage]),
                ],
              ),
            ])),
        bottomNavigationBar: Container(
          height: 70,
          color: AppColors.titleWhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              newButton('ONTEM', current1, 1),
              newButton('HOJE', current2, 2),
              newButton('SEMANA', current3, 3),
            ],
          ),
        ));
  }

  Widget newButton(texto, ativo, index) {
    return ativo
        ? TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primary)),
            onPressed: () {},
            child: Text(texto, style: TextStyles.textWhiteBold),
          )
        : TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.titleWhite)),
            onPressed: () {
              setState(() {
                currentButton(index);
              });
              super.initState();
            },
            child: Text(texto, style: TextStyles.textGrey));
  }

  void currentButton(index) async {
    switch (index) {
      case (1):
        current1 = true;
        current2 = false;
        current3 = false;
        controller.setPage(1);
        break;
      case (2):
        current2 = true;
        current1 = false;
        current3 = false;
        controller.setPage(0);
        break;
      case (3):
        current3 = true;
        current1 = false;
        current2 = false;
        controller.setPage(2);
        break;
    }
  }
}
