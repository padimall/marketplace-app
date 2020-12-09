import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlushBarWarning {
  static show(BuildContext context, String title, String message) async {
    Flushbar(
      title: title,
      message: message,
      margin: EdgeInsets.all(12),
      borderRadius: 8,
      duration: Duration(seconds: 5),
      icon: Icon(
        Icons.info_outline,
        color: Colors.white,
      ),
      backgroundColor: Theme.of(context).accentColor,
    ).show(context);
  }
}
