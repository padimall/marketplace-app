import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class InvoiceDetailPengiriman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Detail Pengiriman',
              style: PadiMallTextTheme.sz13weight600Soft(context),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    'Nomor Resi',
                    style: PadiMallTextTheme.sz11weight500(context),
                  ),
                ),
                Text(
                  'RESI-987654321',
                  style: PadiMallTextTheme.sz12weight600Soft(context),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    'Tanggal Pembelian',
                    style: PadiMallTextTheme.sz11weight500(context),
                  ),
                ),
                Text(
                  '5 September 2020 15:00',
                  style: PadiMallTextTheme.sz12weight600Soft(context),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    'Alamat Pengiriman',
                    style: PadiMallTextTheme.sz11weight500(context),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Jl. Kemana Saja, Gang Sempurna No.10',
                    style: PadiMallTextTheme.sz12weight600(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
