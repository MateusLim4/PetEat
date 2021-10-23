// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:peteat/share/presets/app_text_style.dart';
import 'package:peteat/share/widgets/my-globals.dart';

class HourClass extends StatefulWidget {
  const HourClass({Key? key}) : super(key: key);

  @override
  State<HourClass> createState() => _HourClassState();
}

class _HourClassState extends State<HourClass> {
  @override
  Widget build(BuildContext context) {
    var localHours = hours;
    var localMinutes = minutes;
    var text = '${localHours}:${localMinutes}';

    if ((localHours! > 9) && (localMinutes! > 9)) {
      text = '${localHours}:${localMinutes}';
    } else if ((localHours <= 9) && (localMinutes! <= 9)) {
      text = '0${localHours}:0${localMinutes}';
    } else if ((localHours > 9) && (localMinutes! <= 9)) {
      text = '${localHours}:0${localMinutes}';
    } else if ((localHours <= 9) && (localMinutes! > 9)) {
      text = '0${localHours}:${localMinutes}';
    }

    return Text(text, style: TextStyles.textBlack);
  }
}
