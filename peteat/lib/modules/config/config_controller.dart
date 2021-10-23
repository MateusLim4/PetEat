import 'package:flutter/material.dart';
import 'package:peteat/share/models/hour_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigController {
  final formKey = GlobalKey<FormState>();
  HourModel model = HourModel();

  void onChange({String? hora, String? semana}) {
    model = model.copyWith(hora: hora, semana: semana);
  }

  Future<void> saveHour() async {
    final instance = await SharedPreferences.getInstance();
    final horarios = instance.getStringList("horarios") ?? <String>[];
    horarios.add(model.toJson());
    await instance.setStringList("horarios", horarios);
    return;
  }

  Future<void> cadastrar() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      return await saveHour();
    }
  }
}
