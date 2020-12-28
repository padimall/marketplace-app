import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  static void showInputResi(BuildContext context) {
    showBarModalBottomSheet(
      expand: true,
      context: context,
      builder: (ctx, scrollController) => Material(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close),
                      ),
                    ),
                    Text(
                      'Masukkan Nomor Resi',
                      style: PadiMallTextTheme.sz14weight600(context),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                'assets/images/logistic.svg',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              TextFormField(
                decoration: InputDecoration(
                  suffix: Icon(
                    Icons.clear,
                    size: 15,
                  ),
                  hintText: 'Cari nama supplier anda',
                  hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
