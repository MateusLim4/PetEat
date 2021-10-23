import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peteat/share/widgets/my-globals.dart';

class ClockWidget extends StatefulWidget {
  @override
  _ClockWidgetState createState() {
    return _ClockWidgetState();
  }
}

class _ClockWidgetState extends State<ClockWidget> {
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            selectTime(context);
          },
          child: Text("Selecionar horário"),
        ),
        Text('Novo horário: ${hours}:${minutes}')
      ],
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
        hours = timeOfDay.hour;
        minutes = timeOfDay.minute;
      });
    }
  }
}
