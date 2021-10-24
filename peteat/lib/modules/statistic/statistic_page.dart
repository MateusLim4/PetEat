import 'package:flutter/material.dart';
import 'package:peteat/modules/statistic/grafico_dia.dart';
import 'package:peteat/modules/statistic/grafico_semana.dart';
import 'package:peteat/modules/statistic/statistic_page_controller.dart';
import 'package:peteat/share/presets/app_colors.dart';
import 'package:peteat/share/presets/app_text_style.dart';
import 'package:peteat/share/widgets/my-globals.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final TextEditingController _controllerFood = TextEditingController();
  void quantAlimento() {
    if (_controllerFood.text != '') {
      food = _controllerFood.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var color = AppColors.secondary;
    final configController = StatisticsController();
    final pages = [
      const GraficoDia(),
      const GraficoSemana(),
    ];

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(152),
          child: Container(
            height: 152,
            color: AppColors.titleWhite,
            child: Center(
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BackButton(),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 25),
                            child: Text('Alimentador 01 ',
                                style: TextStyles.pinkTitle),
                          ),
                          TextButton(
                            child: const Icon(Icons.notifications,
                                size: 40, color: AppColors.grey),
                            onPressed: () {},
                          ),
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
          child: Column(
            children: [
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        configController.setPage(0);
                        setState(() {});
                      },
                      child: Text('Hoje'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.grey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        configController.setPage(1);
                        setState(() {});
                      },
                      child: Text('Ontem'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.grey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Semana'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.grey),
                      ),
                    ),
                  ),
                ],
              )),
              Container(
                  width: size.width * 0.95,
                  height: size.height * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.titleWhite,
                  ),
                  child: pages[configController.currentPage]),
            ],
          ),
        ));
  }
}
