import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peteat/functions/formata_hora.dart';
import 'package:peteat/shared/mqtt/mqtt.dart';

import 'package:peteat/shared/notify/notification.dart';
import 'package:peteat/shared/notify/notify_widget.dart';
import 'package:peteat/shared/models/allconfig_db.dart';
import 'package:peteat/shared/models/config_user.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';

class AddEditConfig extends StatefulWidget {
  final ConfigUser? configuracoes;
  const AddEditConfig({Key? key, this.configuracoes}) : super(key: key);

  @override
  _AddEditConfigState createState() => _AddEditConfigState();
}

class _AddEditConfigState extends State<AddEditConfig> {
  late int? hora;
  late int? minuto;
  late String? diaSemana = 'Sem dia definido';
  late int? diaSemanaId;
  late int? alimento;
  late int? notificacaoId;
  late int? notificacaoId2;
  late NotificationWeekAndTime? pickedSchedule;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    configureAndConnect('testLB/intopic');

    isLoading = false;
    hora = widget.configuracoes?.hora ?? 0;
    minuto = widget.configuracoes?.minuto ?? 0;
    diaSemana = widget.configuracoes?.diaSemana ?? 'Sem dia definido';
    diaSemanaId = widget.configuracoes?.diaSemanaId ?? -1;
    alimento = widget.configuracoes?.alimento ?? 0;
    notificacaoId = widget.configuracoes?.notificacaoId ?? 0;
  }

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
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackButton(color: AppColors.primary),
                    Text('Alimentador 01 ', style: TextStyles.pinkTitle),
                    buildButton(),
                  ]),
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.primary,
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: AppColors.secondary))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Container(
                      height: size.height * 0.4,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.titleWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(
                                2, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text('Definir configura????es',
                                style: TextStyles.blueTextBold2),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                initialValue:
                                    alimento == null ? '0' : '$alimento',
                                maxLength: 3,
                                onChanged: (alimento) => setState(() =>
                                    this.alimento = int.tryParse(alimento)),
                                validator: (alimento) => alimento != null &&
                                        int.tryParse(alimento)! <= 500
                                    ? 'O valor m??ximo ?? 500g!'
                                    : '',
                                decoration: const InputDecoration(
                                  labelText:
                                      'Quantidade de alimento (max 500g)',
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('$diaSemana',
                                    style: TextStyles.textBlackLight),
                                Text('${formataHora(hora, minuto)}',
                                    style: TextStyles.blueText),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    pickedSchedule =
                                        await pickSchedule(context);
                                    if (pickedSchedule != null) {
                                      notificacaoId = createUniqueId();
                                      setState(() {
                                        hora = pickedSchedule!.timeOfDay.hour;
                                        minuto =
                                            pickedSchedule!.timeOfDay.minute;
                                        diaSemanaId =
                                            pickedSchedule!.dayOfTheWeek;
                                        switch (diaSemanaId) {
                                          case 7:
                                            diaSemana = 'Domingo';
                                            break;
                                          case 1:
                                            diaSemana = 'Segunda-feira';
                                            break;
                                          case 2:
                                            diaSemana = 'Ter??a-feira';
                                            break;
                                          case 3:
                                            diaSemana = 'Quarta-feira';
                                            break;
                                          case 4:
                                            diaSemana = 'Quinta-feira';
                                            break;
                                          case 5:
                                            diaSemana = 'Sexta-feira';
                                            break;
                                          case 6:
                                            diaSemana = 'S??bado';
                                            break;
                                        }
                                      });
                                    }
                                  },
                                  child: const Text('Definir hor??rio')),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ),
    );
  }

  Widget buildButton() {
    final isFormValid = hora != -1 &&
        minuto != -1 &&
        diaSemanaId != -1 &&
        alimento != -1 &&
        alimento != null &&
        alimento! <= 500;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: AppColors.titleWhite,
          primary: isFormValid ? null : AppColors.stroke,
        ),
        onPressed: addOrUpdate,
        child: const Text('Salvar'),
      ),
    );
  }

  void addOrUpdate() async {
    final isValid = hora != -1 &&
        minuto != -1 &&
        diaSemanaId != -1 &&
        alimento != null &&
        alimento! <= 500;

    if (isValid) {
      final isUpdating = widget.configuracoes != null;

      if (isUpdating) {
        await update();
        await creatConfigEditNotification();
      } else {
        await add();

        await creatConfigNotification();
      }

      Navigator.of(context).pop();
    }
  }

  Future update() async {
    final configs = widget.configuracoes!.copy(
        alimento: alimento,
        diaSemana: diaSemana,
        hora: hora,
        minuto: minuto,
        notificacaoId: notificacaoId,
        diaSemanaId: diaSemanaId);

    pickedSchedule = NotificationWeekAndTime(
        dayOfTheWeek: diaSemanaId!,
        timeOfDay: TimeOfDay(hour: hora!, minute: minuto!));

    createReminderNotification(pickedSchedule!, notificacaoId);
    // await createNotificatioAfter(pickedSchedule!, notificacaoId2);
    await AllConfigDatabase.instance.update(configs);
  }

  Future add() async {
    final configs = ConfigUser(
        alimento: alimento,
        diaSemana: diaSemana,
        hora: hora,
        minuto: minuto,
        notificacaoId: notificacaoId,
        diaSemanaId: diaSemanaId);

    createReminderNotification(pickedSchedule!, notificacaoId);
    //  createNotificatioAfter(pickedSchedule!, notificacaoId2);
    await AllConfigDatabase.instance.create(configs);
  }

  Future disparo() async {
    DateTime yourTime;
    var diferencaHora = hora! - DateTime.now().hour;
    var diferencaMin = minuto! - DateTime.now().minute;
    var diferencaDia = diaSemanaId! - DateTime.now().day - 2;

    if (diferencaMin < 0) {
      diferencaHora = diferencaHora - 1;
      if (diferencaHora < 0) {
        diferencaHora = hora! - 1;
      }
      diferencaMin = 60 + diferencaMin;
    }

    if (diferencaDia < 0) {
      diferencaDia = -diferencaDia;
    }

    void myAction() async {
      // final notify = SaveNotification(idMensagem: createUniqueId());
      // await SaveNotificationDB.instance.create(notify);

      // var payload = 'A:0.0$alimento';
      // if (alimento! > 99) {
      //   payload = 'A:0.$alimento';
      // }
      // publishMessage(payload);

      // configureAndConnect('DISPARO');
      // var response = currentAppState.getHistoryText.split(' ');
      // final isValid = response == [];

      // if (isValid == true) {
      //   var ultimo;

      //   var now = DateTime.now().weekday;
      //   if (response[response.length - 1].contains('A')) {
      //     response = response[response.length - 1].split('A:');
      //   }
      //   ultimo = double.tryParse(response[response.length - 1]);

      //   createNotificatioAfter((alimento! - ultimo));

      //   final consumoQuant =
      //       QuantConsumida(idDiaAtual: now, quantConsumida: ultimo);

      //   if (response != []) {
      //     await QuantConsumidaDB.instance.create(consumoQuant);
      //   }
      // }
      // disconnect();

      // createNotificatioAfter(text);
    }

    Timer(
        Duration(
            days: diferencaDia,
            hours: diferencaHora,
            minutes: diferencaMin,
            milliseconds: 0),
        myAction);
  }
}
