import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/remote_config_services.dart';

void checkAppVersion(BuildContext context) async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  if (await RemoteConfigServices().isForceUpdate()) {
    CustomAlertDialog.forceUpdate(context);
  } else if (await RemoteConfigServices().isNewerUpdateAvailable()) {
    CustomAlertDialog.canUpdate(context);
  }
}