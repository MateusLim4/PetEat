import 'package:flutter/material.dart';
import 'package:peteat/shared/models/notification/save_notification.dart';
import 'package:peteat/shared/models/notification/save_notification_db.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';
import 'package:peteat/shared/themes/font/app_text_style.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<SaveNotification> notificacao;
  bool isLoading = false;

  @override
  void initState() {
    refreshConfigs();
    super.initState();
    isLoading = false;
  }

  Future refreshConfigs() async {
    setState(() => isLoading = true);

    notificacao = await SaveNotificationDB.instance.readAllConfigs();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(152),
          child: Container(
            height: 152,
            color: AppColors.titleWhite,
            child: Center(
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const BackButton(
                  color: AppColors.primary,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 25),
                  child: Text('Notificações', style: TextStyles.pinkTitle),
                ),
              ]),
            ),
          ),
        ),
        backgroundColor: AppColors.primary,
        body: Center(
            child:
                isLoading ? const CircularProgressIndicator() : Container()));
  }
}
