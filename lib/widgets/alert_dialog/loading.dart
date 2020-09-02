import 'package:flutter/material.dart';

Future<String> transparentLoadingCircular(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
          ),
        ),
      );
    },
  );
}
