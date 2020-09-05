import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class CheckoutProdukWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/bawang.jpg',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    'Bawang Putih',
                    style: PadiMallTextTheme.sz12weight600(context),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    'Rp20.000',
                    style: PadiMallTextTheme.sz12weight600Red(context),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Jumlah: 100 Kg',
                      style: PadiMallTextTheme.sz12weight500Grey(context),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
