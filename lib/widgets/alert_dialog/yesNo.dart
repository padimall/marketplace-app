import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

Future<String> showAlertDialogYesNo(
  BuildContext context,
  String titleMessage,
  String bodyMessage,
  String yesButtonTitle,
  String noButtonTitle,
  Function functionYes,
  Function functionNo,
) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: titleMessage.isEmpty
            ? null
            : Text(
                titleMessage,
                style: PadiMallTextTheme.sz16weight700(context),
                textAlign: TextAlign.center,
              ),
        content: bodyMessage.isEmpty
            ? null
            : Text(
                bodyMessage,
                style: PadiMallTextTheme.sz14weight500Grey(context),
              ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              '$yesButtonTitle',
              style: PadiMallTextTheme.sz14weight500(context),
            ),
            onPressed: () {
              functionYes();
            },
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                '$noButtonTitle',
                style: PadiMallTextTheme.sz14weight700White(context),
              ),
              onPressed: () {
                functionNo();
              },
            ),
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      );
    },
  );
}
