import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      _notifications.show(id, title, body, await notificationDetails(),
          payload: payload);

  static notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'timer',
        'Focus',
        channelDescription: 'Notify when focus timer ends.',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }
}
