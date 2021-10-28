import 'package:flutter/material.dart';
import 'package:peteat/share/models/hour_model.dart';
import 'package:peteat/share/widgets/hourlist/hour_list_controller.dart';
import 'package:peteat/share/widgets/timewidget/time_widget.dart';

class HourListWidget extends StatefulWidget {
  final HourListController controller;
  const HourListWidget({Key? key, required this.controller}) : super(key: key);

  @override
  _HourListWidgetState createState() => _HourListWidgetState();
}

class _HourListWidgetState extends State<HourListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<HourModel>>(
        valueListenable: widget.controller.hourNotifier,
        builder: (_, horas, __) => Column(
            children: horas
                .map(
                  (e) => TimeWidget(data: e),
                )
                .toList()));
  }
}
