// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:peteat/share/presets/app_text_style.dart';
import 'package:peteat/share/widgets/my-globals.dart';

class HourClass2 extends StatefulWidget {
  const HourClass2({Key? key}) : super(key: key);

  @override
  State<HourClass2> createState() => _HourClassState();
}

class _HourClassState extends State<HourClass2> {
  @override
  Widget build(BuildContext context) {
    var localHours = hours;
    var localMinutes = minutes;
    var text = '${localHours}:${localMinutes}';

    if ((localHours! > 9) && (localMinutes! > 9)) {
      setState(() {
        text = '${localHours}:${localMinutes}';
      });
    } else if ((localHours <= 9) && (localMinutes! <= 9)) {
      setState(() {
        text = '0${localHours}:0${localMinutes}';
      });
    } else if ((localHours > 9) && (localMinutes! <= 9)) {
      setState(() {
        text = '${localHours}:0${localMinutes}';
      });
    } else if ((localHours <= 9) && (localMinutes! > 9)) {
      setState(() {
        text = '0${localHours}:${localMinutes}';
      });
    }

    return Text(text, style: TextStyles.blueTextBold);
  }
}
