import 'package:flutter/cupertino.dart';
import 'package:peteat/shared/models/hour_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormController {
  final formKey = GlobalKey<FormState>();
  HourModel model = HourModel();

  String? validateHour(String? value) =>
      value?.isEmpty ?? true ? '00:00' : null;
  String? validateWeek(String? value) =>
      value?.isEmpty ?? true ? 'Sem data definida' : null;

  void onChange({String? hour, String? semana}) {
    model = model.copyWith(hour: hour, semana: semana);
  }

  Future<void> saveHorario() async {
    final instance = await SharedPreferences.getInstance();
    final horarios = instance.getStringList("Horarios") ?? <String>[];
    horarios.add(model.toJson());
    print(horarios);
    await instance.setStringList("Horarios", horarios);
  }

  Future<void> cadastrar() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      return await saveHorario();
    }
  }
}
