import 'dart:async';

import 'package:flutter/material.dart';
import 'package:padimall_app/models/start_up_model.dart';
import 'package:padimall_app/screens/login_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpModel>.reactive(
      viewModelBuilder: () => StartUpModel(context: context),
      onModelReady: (model) => StartUpModel(context: context).handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
