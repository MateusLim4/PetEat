import 'package:flutter/material.dart';
import 'package:peteat/modules/form/form_controller.dart';
import 'package:peteat/share/presets/app_colors.dart';
import 'package:peteat/share/presets/app_text_style.dart';
import 'package:peteat/share/widgets/checkbox/checkbox.dart';
import 'package:peteat/share/widgets/timewidget/day_week.dart';
import 'package:peteat/share/widgets/timewidget/hours_little.dart';

class ChangeTime extends StatefulWidget {
  const ChangeTime({Key? key}) : super(key: key);

  @override
  State<ChangeTime> createState() => _ChangeTimeState();
}

class _ChangeTimeState extends State<ChangeTime> {
  TimeOfDay selectedTime = TimeOfDay.now();
  var _hour;
  var _minutes;
  var hora = Hour();
  var semana = DayWeek();

  final controller = FormController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                          padding: const EdgeInsets.only(left: 8.0, right: 25),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: size.height * 0.50,
              width: size.width * 0.90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.titleWhite),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Definir horário', style: TextStyles.pinkTitle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.12,
                            child: TextFormField(
                                validator: controller.validateHour,
                                initialValue: hora.text,
                                onChanged: (value) {
                                  controller.onChange(hora: value);
                                },
                                decoration: InputDecoration(
                                    hintText: hora.text,
                                    fillColor: AppColors.stroke)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              selectTime(context);
                            },
                            child: const Text("Selecionar horário"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.secondary)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(children: [
                          Column(
                            children: const [
                              Text('Dom'),
                              SizedBox(width: 40, child: CheckboxSun()),
                            ],
                          ),
                          Column(
                            children: const [
                              Text('Seg'),
                              SizedBox(width: 40, child: CheckboxMon()),
                            ],
                          ),
                          Column(
                            children: const [
                              Text('Ter'),
                              SizedBox(width: 40, child: CheckboxTu()),
                            ],
                          ),
                          Column(
                            children: const [
                              Text('Qua'),
                              SizedBox(width: 40, child: CheckboxWd()),
                            ],
                          ),
                          Column(
                            children: const [
                              Text('Qui'),
                              SizedBox(width: 40, child: CheckboxTh()),
                            ],
                          ),
                          Column(
                            children: const [
                              Text('Sex'),
                              SizedBox(width: 40, child: CheckboxFr()),
                            ],
                          ),
                          Column(
                            children: const [
                              Text('Sab'),
                              SizedBox(width: 40, child: CheckboxSt()),
                            ],
                          )
                        ]),
                      ),
                      SizedBox(
                        height: size.height * 0.06,
                        child: TextFormField(
                            initialValue: 'Todos os dias da semana',
                            decoration: InputDecoration(
                                hintText: semana.message,
                                fillColor: AppColors.stroke),
                            validator: controller.validateDia),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancelar',
                                style: TextStyle(color: AppColors.buttonRed)),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: AppColors.buttonRed, width: 2.0),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await controller.cadastrar();
                              Navigator.pop(context);
                            },
                            child: const Text('Salvar'),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.secondary)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        _hour = timeOfDay.hour;
        _minutes = timeOfDay.minute;
      });
      hora.formataHora(_hour, _minutes);
    }
  }
}
