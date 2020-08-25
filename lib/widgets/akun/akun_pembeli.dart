import 'package:flutter/material.dart';
import 'package:padimall_app/widgets/akun/list_tile.dart';

class AkunPembeliWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AkunListTile(
          title: 'Informasi Akun',
          subtitle: 'Berisi data diri sebagai pelanggan',
          handler: () {},
        ),
        AkunListTile(
          title: 'Riwayat Pembelian',
          subtitle: 'Berisi data riwayat pembelian Anda',
          handler: () {},
        ),
        AkunListTile(
          title: 'Keluar',
          subtitle: '',
          handler: () {},
        ),
      ],
    );
  }
}
