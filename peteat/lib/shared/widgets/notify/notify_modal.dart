import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:peteat/shared/models/notification/save_notification.dart';
import 'package:peteat/shared/themes/colors/app_colors.dart';

class ModalNotify extends StatelessWidget {
  const ModalNotify({Key? key, required this.notify, required this.index})
      : super(key: key);

  final SaveNotification notify;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.titleWhite,
      child: Container(
        constraints: BoxConstraints(minHeight: 50),
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${Emojis.animals_dog_face}, hora da ração!!!'),
            Text('A ração será liberada em instantes!'),
          ],
        ),
      ),
    );
  }
}
