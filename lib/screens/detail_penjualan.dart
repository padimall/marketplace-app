import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/invoice/brief_info.dart';
import 'package:padimall_app/widgets/invoice/daftar_produk.dart';
import 'package:padimall_app/widgets/invoice/detail_pembayaran.dart';
import 'package:padimall_app/widgets/invoice/detail_pengiriman.dart';

class DetailPenjualanScreen extends StatelessWidget {
  static final routeName = 'detail-penjualan-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penjualan Anda',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 15,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  InvoiceBriefInfo(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(height: 0, thickness: 1,),
                  ),
                  InvoiceDaftarProduk(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(height: 0, thickness: 1,),
                  ),
                  InvoiceDetailPengiriman(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(height: 0, thickness: 1,),
                  ),
                  InvoiceDetailPembayaran(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
