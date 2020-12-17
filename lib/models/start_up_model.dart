import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/screens/first_screen.dart';
import 'package:padimall_app/utils/firebase_messaging_services.dart';
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import 'package:padimall_app/utils/local_notification_services.dart';
import 'package:provider/provider.dart';

class StartUpModel with ChangeNotifier {
  BuildContext context;

  StartUpModel({this.context});

  ProviderUser providerUser;
  ProviderToko providerToko;

  void handleStartUpLogic() async {
    providerUser = Provider.of(context, listen: false);
    providerToko = Provider.of(context, listen: false);

    FirebaseMessagingService.handleNotification();

    LocalNotificationServices.initialize();

    try {
      if (await FlutterSecureStorageServices.getUserToken() != null) {
        await providerToko.getAgentDetail(context);
        if (providerToko.agentDetail == null) {
          await providerToko.getSupplierDetail(context);
        }
      } else if (await FlutterSecureStorageServices.getDevToken() == null) {
        await providerUser.signInDeveloper(context);
      }
    } catch (e) {
      print(e.toString());
    }

    Timer(
      Duration(seconds: 1),
      () => Navigator.pushReplacementNamed(context, FirstScreen.routeName),
    );
  }
}
