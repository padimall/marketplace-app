import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class InvoiceDetailPembayaran extends StatelessWidget {
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
              'Detail Pembayaran',
              style: PadiMallTextTheme.sz13weight600Soft(context),
            ),
          ),
          _buildPembayaranRow(context, 'Metode Pembayaran', 'BCA'),
          _buildPembayaranRow(context, 'Harga barang', 'Rp2.000.000'),
          _buildPembayaranRow(context, 'Ongkos Kirim', 'Rp100.000'),
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total Bayar',
                  style: PadiMallTextTheme.sz12weight600Soft(context),
                ),
                Text(
                  'Rp2.100.000',
                  style: PadiMallTextTheme.sz12weight600Red(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPembayaranRow(
      BuildContext context, String leftText, String rightText) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$leftText',
            style: PadiMallTextTheme.sz12weight500(context),
          ),
          Text(
            '$rightText',
            style: PadiMallTextTheme.sz12weight600Soft(context),
          ),
        ],
      ),
    );
  }
}
