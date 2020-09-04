import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/keranjang/bottom_bar.dart';
import 'package:padimall_app/widgets/keranjang/toko.dart';

class KeranjangScreen extends StatelessWidget {
  static final routeName = 'keranjang-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Keranjang',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Material(
            color: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                  Text(
                    'Pilih semua barang',
                    style: PadiMallTextTheme.sz13weight500(context),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return KeranjangTokoWidget();
                },
              ),
            ),
          ),
          KeranjangBottomBarWidget(),
        ],
      ),
    );
  }
}
