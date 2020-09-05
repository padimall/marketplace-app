import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class CheckoutAlamatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Alamat Pengiriman',
                style: PadiMallTextTheme.sz13weight600(context),
              ),
              Text(
                'Pilih alamat lain',
                style: PadiMallTextTheme.sz13weight600Green(context),
              ),
            ],
          ),
          Divider(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: Text(
              'Jl. Kemana Saja, Gang Sempurna No.10',
              style: PadiMallTextTheme.sz12weight600(context),
            ),
          ),
          Text(
            'Budi Yanto (628123456789)',
            style: PadiMallTextTheme.sz11weight500Grey(context),
          ),
        ],
      ),
    );
  }
}
