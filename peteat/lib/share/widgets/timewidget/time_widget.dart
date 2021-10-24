import 'package:flutter/material.dart';
import 'package:peteat/share/models/hour_model.dart';
import 'package:peteat/share/presets/app_colors.dart';
import 'package:peteat/share/widgets/my-globals.dart';
import 'hours_little.dart';

class TimeWidget extends StatefulWidget {
  final HourModel data;
  const TimeWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  @override
  double _animatedHeight = 0;

  @override
  Widget build(BuildContext context) {
    final HourModel data;
    final size = MediaQuery.of(context).size;
    bool _visible = true;
    var hora = Hour();

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () => setState(() {
              _animatedHeight != 0.0
                  ? _animatedHeight = 0.0
                  : _animatedHeight = 70;
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
                          Text(''),
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
                height: 1,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        child: Text('Excluir'),
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.buttonRed))),
                    ElevatedButton(
                      child: Text('Alterar'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/changeTime');
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.secondary),
                      ),
                    )
                  ],
                )),
            height: _animatedHeight,
          )
        ],
      ),
    );
  }
}
