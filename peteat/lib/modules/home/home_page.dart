import 'package:flutter/material.dart';
import 'package:peteat/shared/models/user_model.dart';
import 'package:peteat/shared/themes/app_colors.dart';
import 'package:peteat/shared/themes/app_text_style.dart';
import 'package:peteat/shared/widgets/logout_modal.dart';

import 'home_page_modal.dart';
import 'home1.dart';
import 'home2.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  final pages = [
    OpsPage(),
    FeederModal(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(152),
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
                            widget.user.name,
                            style: TextStyles.pinkTitle,
                          ),
                          TextButton(
                            child: const Icon(Icons.notifications,
                                size: 40, color: AppColors.grey),
                            onPressed: () {},
                          ),
                        ]),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        backgroundColor: AppColors.primary,
        body: pages[homeController.currentPage],
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.secondary,
          onPressed: () {
            homeController.setPage(1);
            setState(() {});
          },
          child: Icon(Icons.add),
        ));
  }
}
