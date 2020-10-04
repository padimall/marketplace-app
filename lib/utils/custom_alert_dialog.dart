import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/alert_dialog/loading.dart';

class CustomAlertDialog {
  static void loading(BuildContext context) {
    transparentLoadingCircular(context);
  }

  static Future<String> editAndDeletePicture(BuildContext context, Function tapHandler1, Function tapHandler2) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Ubah Gambar'),
                leading: Icon(Icons.edit),
                onTap: tapHandler1,
              ),
              ListTile(
                title: Text('Hapus Gambar'),
                leading: Icon(Icons.delete),
                onTap: tapHandler2,
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<String> dialogOfTwo(
    BuildContext context,
    bool isDismissible,
    String title,
    String body,
    String leftButtonLabel,
    String rightButtonLabel,
    Function leftButtonFunctionHandler,
    Function rightButtonFunctionHandler,
  ) {
    return showDialog<void>(
      context: (context),
      barrierDismissible: isDismissible, // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            '$title',
            style: PadiMallTextTheme.sz14weight600Soft(context),
          ),
          content: Text(
            '$body',
            style: PadiMallTextTheme.sz13weight500(context),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('${leftButtonLabel}', style: PadiMallTextTheme.sz13weight600Soft(context)),
              onPressed: leftButtonFunctionHandler,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: RaisedButton(
                child: Text('${rightButtonLabel}', style: PadiMallTextTheme.sz13weight600White(context)),
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                onPressed: rightButtonFunctionHandler,
              ),
            ),
          ],
        );
      },
    );
  }
}
