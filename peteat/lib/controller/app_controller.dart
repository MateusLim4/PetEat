import 'package:flutter/material.dart';
import 'package:peteat/modules/Login/login_page.dart';
import 'package:peteat/modules/config/config_page.dart';
import 'package:peteat/modules/home/home_page.dart';
import 'package:peteat/modules/models/user_model.dart';
import 'package:peteat/modules/splash/splash_page.dart';
import 'package:peteat/modules/statistic/statistic_page.dart';

class WidgetController extends StatelessWidget {
  const WidgetController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Peteat",
        initialRoute: '/splash',
        debugShowCheckedModeBanner: false,
        routes: {
          "/splash": (context) => SplashPage(),
          "/login": (context) => LoginPage(),
          "/home": (context) => HomePage(
              user: ModalRoute.of(context)!.settings.arguments as UserModel),
          "/config": (context) => ConfigPage(
              user: ModalRoute.of(context)!.settings.arguments as UserModel),
          "/statistics": (context) => Statistics(
              user: ModalRoute.of(context)!.settings.arguments as UserModel),
        });
  }
}
