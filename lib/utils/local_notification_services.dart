import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  static void initialize() async {
    print('Initializing Notification..');
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // final NotificationAppLaunchDetails notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    print('Notification initialized..');
  }
}
