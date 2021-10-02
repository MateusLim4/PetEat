import 'package:flutter/material.dart';
import 'package:peteat/modules/splash/splash_page.dart';

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
        });
  }
}