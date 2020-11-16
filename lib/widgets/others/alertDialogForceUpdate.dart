import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:url_launcher/url_launcher.dart';


Future<String> showAlertDialogForceUpdate(
    BuildContext context,
    String titleMessage,
    String bodyMessage,
    String appUrl,
    ) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(titleMessage),
          content: Text(
            bodyMessage,
            style: PadiMallTextTheme.sz13weight500(context),
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: RaisedButton(
                child: Text(
                  'Update',
                  style: PadiMallTextTheme.sz16weight700White(context),
                ),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                onPressed: () async {
                  if (await canLaunch(appUrl)) {
                    await launch(appUrl);
                  } else {
                    throw 'Could not launch $appUrl';
                  }
                },
              ),
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