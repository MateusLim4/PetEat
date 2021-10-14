import 'package:flutter/material.dart';
import 'package:weekday_selector/weekday_selector.dart';

class ExampleWidget extends StatefulWidget {
  // We start with all days selected.

  const ExampleWidget({Key? key}) : super(key: key);

  @override
  State<ExampleWidget> createState() => _ExampleWidget();
}

class _ExampleWidget extends State<ExampleWidget> {
  List<bool> values = List.filled(7, false);

  @override
  Widget build(BuildContext context) {
    return WeekdaySelector(
      onChanged: (int day) {
        setState(() {
          // Set all values to false except the "day"th element
          values = List.filled(7, false, growable: false)..[day % 7] = true;
        });
      },
      values: values,
    );
  }
}
