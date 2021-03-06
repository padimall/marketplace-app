import 'package:flutter/material.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/screens/info_buyer_screen.dart';
import 'package:padimall_app/screens/login_screen.dart';
import 'package:padimall_app/screens/pembelian_screen.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import 'package:padimall_app/widgets/akun/list_tile.dart';
import 'package:padimall_app/widgets/alert_dialog/yesNo.dart';
import 'package:provider/provider.dart';

class AkunPembeliWidget extends StatelessWidget {
  ProviderUser _providerUser;

  @override
  Widget build(BuildContext context) {
    _providerUser = Provider.of(context, listen: false);

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
            CustomAlertDialog.dialogOfTwo(
                context, true, 'Yakin ingin keluar?', 'Kamu perlu login kembali jika ingin melanjutkan aktivitas sebelumnya', 'Keluar', 'Batal', () {
              FlutterSecureStorageServices.deleteUserToken();
              Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
            }, () {
              Navigator.pop(context);
            });
          },
        ),
        _buildWidgetAppVersion(context),
      ],
    );
  }

  Widget _buildWidgetAppVersion(BuildContext context) {
    _providerUser.getPackageInfo();

    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Text(
              'Versi: ${_providerUser.packageInfo.version + ' (' + _providerUser.packageInfo.buildNumber})',
              style: PadiMallTextTheme.sz13weight500(context),
            ),
          ),
        ),
      ],
    );
  }
}
