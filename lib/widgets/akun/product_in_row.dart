import 'package:flutter/material.dart';
import 'package:padimall_app/screens/produk_edit_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class ProductInRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/bawang.jpg',
                height: 75,
                width: 75,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Bawang Putih',
                      style: PadiMallTextTheme.sz14weight700(context),
                    ),
                    Text(
                      'Rp20.000',
                      style: PadiMallTextTheme.sz14weight600Red(context),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Stok 500 Kg',
                    style: PadiMallTextTheme.sz12weight500Grey(context),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProdukEditScreen.routeName);
                  },
                  child: Text(
                    'Ubah',
                    style: PadiMallTextTheme.sz13weight700Green(context),
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
