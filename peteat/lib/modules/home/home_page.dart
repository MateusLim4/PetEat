import 'package:flutter/material.dart';
import 'package:peteat/modules/models/user_model.dart';
import 'package:peteat/share/presets/app_colors.dart';
import 'package:peteat/share/presets/app_text_style.dart';

import '../../share/widgets/home_page_modal.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(152),
          child: Container(
            height: 152,
            color: AppColors.titleWhite,
            child: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(children: [
                            TextButton(
                              onPressed: () {},
                              child: Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: NetworkImage(widget.user.photoURL!),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Hello, ',
                                  style: TextStyles.pinkTitleThin),
                            ),
                            Text(
                              "${widget.user.name}",
                              style: TextStyles.pinkTitle,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Container(
                                  child: TextButton(
                                child: Icon(Icons.notifications,
                                    size: 40, color: AppColors.grey),
                                onPressed: () {},
                              )),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        backgroundColor: AppColors.primary,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                child: Text('Dispositivos conectados',
                    style: TextStyles.titleHomeThin),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
              child: Container(
                width: size.width,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/saddog.png',
                      height: size.height * 0.23,
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
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: ModalHomeWidget()
            // label: const Text('Novo Alimentador',
            //     style: TextStyle(fontWeight: FontWeight.bold)),
            // icon: const Icon(Icons.add),
            // backgroundColor: AppColors.secondary,
            ));
  }
}
