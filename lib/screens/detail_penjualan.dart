import 'package:flutter/material.dart';
import 'package:padimall_app/providers/histories.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/invoice/brief_info.dart';
import 'package:padimall_app/widgets/invoice/daftar_produk.dart';
import 'package:padimall_app/widgets/invoice/detail_pembayaran.dart';
import 'package:padimall_app/widgets/invoice/detail_pengiriman.dart';
import 'package:provider/provider.dart';

class DetailPenjualanScreen extends StatelessWidget {
  static final routeName = 'detail-penjualan-screen';

  ProviderHistories _providerHistories;

  @override
  Widget build(BuildContext context) {
    _providerHistories = Provider.of(context, listen: false);
    final String invoiceId = ModalRoute.of(context).settings.arguments;

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
      body: buildFutureBuilder(
        _providerHistories.getInvoiceDetail(context, invoiceId),
        Consumer<ProviderHistories>(
          builder: (ctx, provider, _) => Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      InvoiceBriefInfo(
                        invoiceDetail: _providerHistories.invoiceDetail,
                        role: 'seller',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(
                          height: 0,
                          thickness: 1,
                        ),
                      ),
                      InvoiceDaftarProduk(
                        invoiceDetail: _providerHistories.invoiceDetail,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(
                          height: 0,
                          thickness: 1,
                        ),
                      ),
                      InvoiceDetailPengiriman(
                        invoiceDetail: _providerHistories.invoiceDetail,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(
                          height: 0,
                          thickness: 1,
                        ),
                      ),
                      InvoiceDetailPembayaran(
                        invoiceDetail: _providerHistories.invoiceDetail,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
