import 'package:flutter/material.dart';
import 'package:peteat/share/models/user_model.dart';
import 'package:peteat/share/presets/app_colors.dart';
import 'package:peteat/share/presets/app_text_style.dart';
import 'package:peteat/share/widgets/my-globals.dart';
import 'package:peteat/share/widgets/timewidget/time_widget.dart';

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
  void diaSemana() {
    var lista = [domingo, segunda, terca, quarta, quinta, sexta, sabado];
    var week = [
      'Domingo',
      'Segunda',
      'Terça',
      'Quarta',
      'Quinta',
      'Sexta',
      'Sábado'
    ];
    var days = [];

    int count = 0;
    lista.forEach((element) {
      if (element == true) {
        days.add(week[count]);
      }
      count = count + 1;
    });

    switch (days.length) {
      case 0:
        message = 'Sem data definida';
        break;
      case 1:
        message = '${days[0]}';
        break;
      case 2:
        if (days[0] == 'Sábado' && days[1] == 'Domingo') {
          message = "Apenas aos fins de semana";
        } else {
          message = '${days[0]} e ${days[1]}';
        }
        break;
      case 3:
        message = '${days[0]}, ${days[1]} e ${days[2]}';
        break;
      case 4:
        message = '${days[0]}, ${days[1]},${days[2]} e ${days[3]}';
        break;
      case 5:
        if (days[0] == 'Segunda' &&
            days[1] == 'Terça' &&
            days[2] == 'Quarta' &&
            days[3] == 'Quinta' &&
            days[4] == 'Sexta') {
          message = "Apenas nos dias úteis";
        } else {
          message =
              '${days[0]}, ${days[1]}, ${days[2]}, ${days[3]} ,${days[4]}';
        }
        break;
      case 6:
        message =
            '${days[0]}, ${days[1]}, ${days[2]}, ${days[3]}, ${days[4]} e ${days[5]}';
        break;
      case 7:
        message = 'Todos os dias';
        break;
      default:
    }
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Widget> v = [TimeWidget()];

    void buildRow() {
      v.add(TimeWidget());
    }

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
                    ElevatedButton(
                      onPressed: () {
                        quantAlimento();
                        diaSemana();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    super.widget));
                      },
                      child: const Text('Salvar'),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
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
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text('Horários',
                                    style: TextStyles.blueText),
                              ),
                              v[0],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        buildRow();
                      },
                      child: const Text('Adicionar novo horário')),
                )
              ],
            ),
          ),
        ));
  }
}
