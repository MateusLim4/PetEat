import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controller/app_controller.dart';

void main() {
  runApp(
    const AppFirebase(),
  );
}

class AppFirebase extends StatefulWidget {
  const AppFirebase({Key? key}) : super(key: key);

  @override
  State<AppFirebase> createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Material(
            child: Center(
              child: Text(
                "Não foi possivel inicializar o firebase",
                textDirection: TextDirection.ltr,
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return const WidgetController();
        } else {
          return const Material(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
