import 'package:flutter/material.dart';
import 'package:padimall_app/screens/info_buyer_screen.dart';
import 'package:padimall_app/screens/login_screen.dart';
import 'package:padimall_app/screens/pembelian_screen.dart';
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import 'package:padimall_app/widgets/akun/list_tile.dart';
import 'package:padimall_app/widgets/alert_dialog/yesNo.dart';

class AkunPembeliWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AkunListTile(
          title: 'Informasi Akun',
          subtitle: 'Berisi data diri sebagai pelanggan',
          handler: () {
            Navigator.pushNamed(context, InfoBuyerScreen.routeName);
          },
        ),
        AkunListTile(
          title: 'Riwayat Pembelian',
          subtitle: 'Berisi data riwayat pembelian Anda',
          handler: () {
            Navigator.pushNamed(context, PembelianScreen.routeName);
          },
        ),
        AkunListTile(
          title: 'Keluar',
          subtitle: '',
          handler: () {
            showAlertDialogYesNo(context, 'Yakin ingin keluar?', 'Kamu perlu login kembali jika ingin melanjutkan aktivitas sebelumnya', 'Keluar', 'Batal', () {
              FlutterSecureStorageServices.deleteUserToken();
              Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
            }, () {
              Navigator.pop(context);
            });
          },
        ),
      ],
    );
  }
}
