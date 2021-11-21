import 'package:flutter/material.dart';
import 'package:peteat/modules/Login/login_page.dart';
import 'package:peteat/modules/config/config_page.dart';
import 'package:peteat/modules/home/home_page.dart';
import 'package:peteat/modules/splash/splash_page.dart';
import 'package:peteat/shared/models/user_model.dart';

class WidgetController extends StatelessWidget {
  const WidgetController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Peteat",
        initialRoute: '/splash',
        debugShowCheckedModeBanner: false,
        routes: {
          "/splash": (context) => const SplashPage(),
          "/login": (context) => const LoginPage(),
          "/home": (context) => HomePage(
              user: ModalRoute.of(context)!.settings.arguments as UserModel),
          "/config": (context) => const ConfigPage(),
        });
  }
}
