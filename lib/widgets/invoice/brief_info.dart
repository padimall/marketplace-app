import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class InvoiceBriefInfo extends StatelessWidget {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    'Nomor Invoice',
                    style: PadiMallTextTheme.sz11weight500(context),
                  ),
                ),
                Text(
                  'INV/20200825/XX/VIII/123456',
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
                    'Status',
                    style: PadiMallTextTheme.sz11weight500(context),
                  ),
                ),
                Text(
                  'Pesanan Selesai',
                  style: PadiMallTextTheme.sz12weight600Green(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
