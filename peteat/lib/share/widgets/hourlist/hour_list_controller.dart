import 'package:flutter/material.dart';
import 'package:peteat/share/models/hour_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HourListController {
  final hourNotifier = ValueNotifier<List<HourModel>>(<HourModel>[]);

  List<HourModel> get horas => hourNotifier.value;
  set horas(List<HourModel> value) => hourNotifier.value = value;

  HourListController() {
    getHours();
  }

  void getHours() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList('Horas');
      horas = response!.map((e) => HourModel.fromJson(e)).toList();
    } catch (e) {}
  }

  void dispose() {
    hourNotifier.dispose();
  }
}
