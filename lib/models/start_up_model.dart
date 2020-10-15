import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/screens/first_screen.dart';
import 'package:provider/provider.dart';

class StartUpModel with ChangeNotifier {
  BuildContext context;
  StartUpModel({this.context});
  ProviderUser providerUser;

  void handleStartUpLogic() async {
    providerUser = Provider.of(context, listen: false);
    await providerUser.signInDeveloper(context);

    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, FirstScreen.routeName),
    );
  }
}
