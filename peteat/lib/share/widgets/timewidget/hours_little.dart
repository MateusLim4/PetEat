import 'package:flutter/material.dart';
import 'package:peteat/share/presets/app_text_style.dart';

class Hour {
  var text = '00:00';

  void formataHora(int localHours, int localMinutes) {
    if ((localHours > 9) && (localMinutes > 9)) {
      text = '$localHours:$localMinutes';
    } else if ((localHours <= 9) && (localMinutes <= 9)) {
      text = '0$localHours:0$localMinutes';
    } else if ((localHours > 9) && (localMinutes <= 9)) {
      text = '$localHours:0$localMinutes';
    } else if ((localHours <= 9) && (localMinutes > 9)) {
      text = '0$localHours:$localMinutes';
    }
  }

  void adiantar() {
    int hours;
    int minutes;

    DateTime now = DateTime.now();
    hours = now.hour.toInt();
    minutes = now.minute.toInt() + 5;
    if (minutes > 59) {
      minutes = minutes - 60;
      hours = hours + 1;
    }
    formataHora(hours, minutes);
    print(text);
  }
}
