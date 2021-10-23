import 'package:flutter/material.dart';
import 'package:peteat/share/models/user_model.dart';
import 'package:peteat/share/presets/app_colors.dart';
import 'package:peteat/share/presets/app_text_style.dart';
import 'package:peteat/share/widgets/timewidget/hours_big.dart';
import 'package:peteat/share/widgets/my-globals.dart';

class FeederModal extends StatefulWidget {
  // final UserModel user;
  const FeederModal({Key? key}) : super(key: key);

  @override
  State<FeederModal> createState() => _FeederModalState();
}

class _FeederModalState extends State<FeederModal> {
  @override
  double _animatedHeight = 200;

  @override
  Widget build(BuildContext context) {
    void adiantar() {
      DateTime now = DateTime.now();
      hours = now.hour.toInt();
      minutes = now.minute.toInt() + 5;
      if (minutes! > 59) {
        minutes = minutes! - 60;
        hours = hours! + 1;
      }
      // Navigator.pushReplacementNamed(context, "/home",
      //     arguments: UserModel(
      //         name: widget.user.name, photoURL: widget.user.photoURL!));
    }

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                    onTap: () => setState(() {
                          _animatedHeight != 0.0
                              ? _animatedHeight = 0.0
                              : _animatedHeight = 200.0;
                        }),
                    child: Column(
                      children: [
                        Container(
                            height: size.height * 0.1,
                            width: size.width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3),
                                  topRight: Radius.circular(3)),
                              color: AppColors.secondary,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 15, right: 15, bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child:
                                        Image.asset('assets/images/racao.png'),
                                  ),
                                  Text('Alimentador 01',
                                      style: TextStyles.textWhite),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/statistics',
                                      );
                                    },
                                    child: Text(
                                      'Relatório',
                                      style: TextStyles.textWhiteBold,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: AppColors.titleWhite,
                                          width: 2.0),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                      ],
                    )),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.titleWhite,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(2, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    const HourClass2(),
                                    Text('Proxima liberação de\n ração',
                                        style: TextStyles.textBlackLight,
                                        textAlign: TextAlign.center),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            "/config",
                                          );
                                        },
                                        child: Text('Configurar',
                                            style: TextStyles.textWhiteBold),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    AppColors.secondary)),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('${food!}g',
                                        style: TextStyles.blueTextBold),
                                    Text('Quantidade de ração\n definida',
                                        style: TextStyles.textBlackLight,
                                        textAlign: TextAlign.center),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          adiantar();
                                        },
                                        child: Text('Antecipar',
                                            style: TextStyles.blueText),
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              color: AppColors.secondary,
                                              width: 2.0),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                  height: _animatedHeight,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
