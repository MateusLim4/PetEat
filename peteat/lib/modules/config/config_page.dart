import 'package:flutter/material.dart';
import 'package:peteat/shared/themes/app_colors.dart';
import 'package:peteat/shared/themes/app_text_style.dart';
import 'package:peteat/shared/widgets/hourlist/hour_list_controller.dart';
import 'package:peteat/shared/widgets/hourlist/hour_list_widget.dart';
import 'package:peteat/shared/widgets/my-globals.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final TextEditingController _controllerFood = TextEditingController();
  void quantAlimento() {
    if (_controllerFood.text != '') {
      food = _controllerFood.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = HourListController();

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
                          const BackButton(color: AppColors.primary),
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
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Configurações',
                      style: TextStyles.titleHomeThin,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                      height: size.height * 0.15,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.titleWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(2, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 8.0, left: 5),
                                child:
                                    Text('Ração', style: TextStyles.blueText),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Quantidade (g):',
                                      style: TextStyles.textBlackLight),
                                  SizedBox(
                                      height: size.height * 0.06,
                                      width: size.width * 0.62,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: _controllerFood,
                                        decoration: InputDecoration(
                                            hintText: "Valor atual: ${food}g"),
                                      ))
                                ],
                              ),
                            ]),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    height: size.height * 0.45,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.titleWhite,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(2, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text('Horários',
                                        style: TextStyles.blueText),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/changeTime');
                                      },
                                      child: const Text('Novo horário'),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.secondary)),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: HourListWidget(
                                  controller: controller,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      quantAlimento();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => super.widget));
                    },
                    child: const Text('Salvar'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.secondary)),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
