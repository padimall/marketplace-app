import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:padimall_app/models/notification_message.dart';

class FirebaseMessagingService {
  static getDeviceToken() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    return await firebaseMessaging.getToken();
  }

  static void notificationHandler(NotificationMessage notificationMessage) async {
    var _channelName;
    var _channelDesc;
    var _priority = Priority.high;
    var _importance = Importance.high;
    print('hi');
    print(notificationMessage.data.androidChannelId);
    if (notificationMessage.data.androidChannelId != null) {
      switch (notificationMessage.data.androidChannelId) {
        case "001":
          _channelName = "Pesanan";
          _channelDesc = "Notif Pesanan";
          _priority = Priority.high;
          _importance = Importance.high;
          break;
        default:
          _channelName = "Default";
          _channelDesc = "Notif default";
          _priority = Priority.high;
          _importance = Importance.high;
          break;
      }
    }

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      notificationMessage.data.androidChannelId,
      _channelName,
      _channelDesc,
      priority: _priority,
      importance: _importance,
      enableVibration: true,
      enableLights: true,
      icon: "@mipmap/ic_launcher",
    );

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    print('tembak ${notificationMessage.data.title}');
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.show(0, notificationMessage.data.title, notificationMessage.data.body, notificationDetails);
  }

  static Future<dynamic> _onBackgroundMessage(Map<String, dynamic> message) {
    print('onBackgroundMessage: $message');
    var notificationMessage = NotificationMessage.fromJson(message);
    notificationHandler(notificationMessage);
  }

  static handleNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        var notificationMessage = NotificationMessage.fromJson(message);
        notificationHandler(notificationMessage);
      },
      onBackgroundMessage: _onBackgroundMessage,
    );
  }
}
