import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/keranjang/produk.dart';

class KeranjangTokoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 16),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Checkbox(
                value: true,
                onChanged: (value) {},
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Toko Subur Selalu',
                      style: PadiMallTextTheme.sz13weight600(context),
                    ),
                    Text(
                      'Medan, Sumatera utara',
                      style: PadiMallTextTheme.sz10weight500Grey(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          KeranjangProdukWidget(),
        ],
      ),
    );
  }
}
