import 'package:flutter/material.dart';
import 'package:peteat/share/presets/app_colors.dart';
import 'package:peteat/share/widgets/clock.dart';
import 'package:peteat/share/widgets/my-globals.dart';

import 'checkbox/checkbox.dart';
import 'hours_little.dart';

class TimeWidget extends StatefulWidget {
  const TimeWidget({Key? key}) : super(key: key);

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  @override
  Future<void> _show() async {
    String? _selectedTime;

    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
    }
  }

  double _animatedHeight = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool _visible = true;
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () => setState(() {
              _animatedHeight != 0.0
                  ? _animatedHeight = 0.0
                  : _animatedHeight = 150;
              setState(
                () {
                  _visible = !_visible;
                },
              );
            }),
            child: Container(
                height: size.height * 0.1,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.titleWhite,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HourClass(),
                          Text(message, style: TextStyle(fontSize: 11)),
                        ],
                      ),
                      SizedBox(
                          height: 20,
                          child: Image.asset('assets/images/bleach.png'))
                    ],
                  ),
                )),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            child: Container(
                height: size.height * 2,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  color: AppColors.titleWhite,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(children: [
                      Column(
                        children: const [
                          Text('Dom'),
                          CheckboxSun(),
                        ],
                      ),
                      Column(
                        children: const [
                          Text('Seg'),
                          CheckboxMon(),
                        ],
                      ),
                      Column(
                        children: const [
                          Text('Ter'),
                          CheckboxTu(),
                        ],
                      ),
                      Column(
                        children: const [
                          Text('Qua'),
                          CheckboxWd(),
                        ],
                      ),
                      Column(
                        children: const [
                          Text('Qui'),
                          CheckboxTh(),
                        ],
                      ),
                      Column(
                        children: const [
                          Text('Sex'),
                          CheckboxFr(),
                        ],
                      ),
                      Column(
                        children: const [
                          Text('Sab'),
                          CheckboxSt(),
                        ],
                      )
                    ]),
                    ClockWidget(),
                  ],
                )),
            height: _animatedHeight,
          )
        ],
      ),
    );
  }
}
