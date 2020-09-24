import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  static getDeviceToken() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    return await firebaseMessaging.getToken();
  }
}