import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

Future<String> showAlertDialogOk(
    BuildContext context,
    bool isMayPop,
    String titleMessage,
    String bodyMessage,
    String okButtonMessage,
    Function functionOK,
    ) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          title: Text(titleMessage, style: PadiMallTextTheme.sz14weight600(context),),
          content: Text(
            bodyMessage,
            style: PadiMallTextTheme.sz14weight500(context),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                '$okButtonMessage',
                style: PadiMallTextTheme.sz14weight700Green(context),
              ),
              onPressed: () {
                functionOK();
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
      );
    },
  );
}