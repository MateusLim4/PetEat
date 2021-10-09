import 'package:flutter/material.dart';
import 'package:peteat/modules/models/user_model.dart';
import 'package:peteat/share/presets/app_colors.dart';
import 'package:peteat/share/presets/app_text_style.dart';
import 'package:peteat/share/widgets/logout_modal.dart';

import '../../share/widgets/home_page_modal.dart';
import 'home1.dart';
import 'home2.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final homeController = HomeController();
final pages = [
  Container(color: Colors.red),
  Container(color: Colors.blue),
];

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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(children: [
                            Logout(
                                user: ModalRoute.of(context)!.settings.arguments
                                    as UserModel),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Hello, ',
                                  style: TextStyles.pinkTitleThin),
                            ),
                            Text(
                              "${widget.user.name}",
                              style: TextStyles.pinkTitle,
                            ),
                            Container(
                              child: TextButton(
                                child: Icon(Icons.notifications,
                                    size: 40, color: AppColors.grey),
                                onPressed: () {},
                              ),
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
        body: FeederModal(),
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: ModalHomeWidget()));
  }
}
