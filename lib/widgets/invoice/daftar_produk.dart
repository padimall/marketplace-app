import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/checkout/produk.dart';
import 'package:padimall_app/widgets/invoice/produk.dart';

class InvoiceDaftarProduk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Daftar Produk',
            style: PadiMallTextTheme.sz13weight600Soft(context),
          ),
          ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return InvoiceProdukWidget();
            },
          ),
        ],
      ),
    );
  }
}
