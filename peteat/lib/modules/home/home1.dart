import 'package:flutter/material.dart';
import 'package:peteat/shared/notify/notification.dart';
import 'package:peteat/shared/notify/notify_widget.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';

class OpsPage extends StatelessWidget {
  const OpsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child:
              Text('Dispositivos conectados', style: TextStyles.titleHomeThin),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
          child: SizedBox(
            width: size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/saddog.png',
                      height: size.height * 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Text.rich(TextSpan(
                          text: '"OPS!!!',
                          style: TextStyles.textWhiteBold,
                          children: [
                            TextSpan(
                              text:
                                  ' \n Parece que \n voce nao possui\n nenhum alimentador \n disponivel"',
                              style: TextStyles.textWhite,
                            )
                          ])),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
