import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'controller/app_controller.dart';

void main() {
  AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Canal de comunicação',
        defaultColor: AppColors.primary,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
      NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: "Scheduled Notifications",
          defaultColor: AppColors.primary,
          locked: true,
          importance: NotificationImportance.High,
          soundSource: 'resource://raw/res_custom_notification')
    ],
  );
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
