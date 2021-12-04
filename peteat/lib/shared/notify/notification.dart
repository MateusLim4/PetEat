import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:peteat/shared/notify/notify_widget.dart';

Future<void> creatConfigNotification() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: createUniqueId(),
    channelKey: 'basic_channel',
    title: 'Isso aeeeeeeeee!!!',
    body: 'Configuração salva com sucesso!',
    notificationLayout: NotificationLayout.Default,
  ));
}

Future<void> creatConfigEditNotification() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: createUniqueId(),
    channelKey: 'basic_channel',
    title: '${Emojis.smile_smiling_face} Aeeeeeeeee!!!',
    body: 'Configuração alterada com sucesso!',
    notificationLayout: NotificationLayout.Default,
  ));
}

Future<void> antecipateNotification() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: createUniqueId(),
    channelKey: 'basic_channel',
    title: '${Emojis.animals_dog} Aeeeeeeeee!!!',
    body: 'A ração será liberada em instantes!',
    notificationLayout: NotificationLayout.Default,
  ));
}

Future<void> deleteConfigNotification() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: createUniqueId(),
    channelKey: 'basic_channel',
    title: '${Emojis.smile_crying_face}, Deletado!',
    body: 'Configuração deletada com sucesso!',
    notificationLayout: NotificationLayout.Default,
  ));
}

Future<void> createReminderNotification(
    NotificationWeekAndTime notificationSchedule, id) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'scheduled_channel',
          title: '${Emojis.animals_dog_face}, hora da ração!!!',
          body: 'A ração será liberada em instantes!',
          notificationLayout: NotificationLayout.Default),
      schedule: NotificationCalendar(
        weekday: notificationSchedule.dayOfTheWeek,
        hour: notificationSchedule.timeOfDay.hour,
        minute: notificationSchedule.timeOfDay.minute,
        second: 0,
        millisecond: 0,
        repeats: true,
      ));
}

Future<void> createNotificatioAfter(text) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: createUniqueId(),
    channelKey: 'basic_channel',
    title: text != 0 ? 'Ração liberada!!' : 'Ração não foi liberada ;-;',
    body:
        text == 0 ? 'Foi depositado ${text}g' : 'Parece que seu pet não comeu.',
    notificationLayout: NotificationLayout.Default,
  ));
}
