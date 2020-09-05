import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/show_modal_bottom.dart';
import 'package:padimall_app/widgets/checkout/alamat.dart';
import 'package:padimall_app/widgets/checkout/toko.dart';

class CheckoutScreen extends StatelessWidget {
  static final routeName = 'checkout-screen';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengiriman',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 15,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CheckoutAlamatWidget(),
                  ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return CheckoutTokoWidget();
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[100],
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 0),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Total Harga',
                      style: PadiMallTextTheme.sz12weight600(context),
                    ),
                    Text(
                      'Rp2.000.000',
                      style: PadiMallTextTheme.sz14weight600Red(context),
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: () {

                  },
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  child: Text(
                    'Pilih Pembayaran',
                    style: PadiMallTextTheme.sz14weight700White(context),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
