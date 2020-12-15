import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class PadiMallShowModalBottom {
  static void showDurasiPengiriman(BuildContext context) {
    showBarModalBottomSheet(
      expand: false,
      context: context,
      builder: (ctx, scrollController) => Material(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close),
                    ),
                  ),
                  Text(
                    'Durasi Pengiriman',
                    style: PadiMallTextTheme.sz14weight600(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
