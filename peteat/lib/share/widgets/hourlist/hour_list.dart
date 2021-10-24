import 'package:flutter/material.dart';
import 'package:peteat/share/models/hour_model.dart';
import 'package:peteat/share/widgets/timewidget/time_widget.dart';
import 'hour_list_controller.dart';

class HourListWidget extends StatefulWidget {
  const HourListWidget({Key? key}) : super(key: key);

  @override
  _HourListWidget createState() => _HourListWidget();
}

class _HourListWidget extends State<HourListWidget> {
  final controller = HourListController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<HourModel>>(
        valueListenable: controller.hourNotifier,
        builder: (_, horas, __) => Column(
              children: horas
                  .map(
                    (e) => TimeWidget(
                      data: e,
                    ),
                  )
                  .toList(),
            ));
  }
}
