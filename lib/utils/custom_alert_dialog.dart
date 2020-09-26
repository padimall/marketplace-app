import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
}