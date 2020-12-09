import 'package:flutter/material.dart';
import 'package:padimall_app/providers/histories.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/invoice/action_section.dart';
import 'package:padimall_app/widgets/invoice/brief_info.dart';
import 'package:padimall_app/widgets/invoice/daftar_produk.dart';
import 'package:padimall_app/widgets/invoice/detail_pembayaran.dart';
import 'package:padimall_app/widgets/invoice/detail_pengiriman.dart';
import 'package:provider/provider.dart';

class DetailPembelianScreen extends StatelessWidget {
  static final routeName = 'detail-pembelian-screen';

  ProviderHistories _providerHistories;
  bool isInvoiceGroup;
  String invoiceId;
  String invoiceGroupId;

  @override
  Widget build(BuildContext context) {
    _providerHistories = Provider.of(context, listen: false);
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    isInvoiceGroup = args['is_invoice_group'];
    if (isInvoiceGroup) {
      invoiceGroupId = args['invoice_id'];
    } else {
      invoiceId = args['invoice_id'];
    }

    print('check: ${isInvoiceGroup}');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pembelian Anda',
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
        isInvoiceGroup ? _providerHistories.getInvoiceGroupDetail(context, invoiceGroupId) : _providerHistories.getInvoiceDetail(context, invoiceId),
        Consumer<ProviderHistories>(
          builder: (ctx, provider, _) => Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      InvoiceBriefInfo(
                        invoiceDetail: isInvoiceGroup ? null : _providerHistories.invoiceDetail,
                        invoiceGroupDetail: isInvoiceGroup ? _providerHistories.invoiceGroupDetail : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(
                          height: 0,
                          thickness: 1,
                        ),
                      ),
                      InvoiceDaftarProduk(
                        invoiceDetail: isInvoiceGroup ? null : _providerHistories.invoiceDetail,
                        invoiceGroupDetail: isInvoiceGroup ? _providerHistories.invoiceGroupDetail : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(
                          height: 0,
                          thickness: 1,
                        ),
                      ),
                      if (!isInvoiceGroup)
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
                        invoiceDetail: isInvoiceGroup ? null : _providerHistories.invoiceDetail,
                        invoiceGroupDetail: isInvoiceGroup ? _providerHistories.invoiceGroupDetail : null,
                      ),
                    ],
                  ),
                ),
              ),
              InvoiceActionSection(
                invoiceDetail: isInvoiceGroup ? null : _providerHistories.invoiceDetail,
                invoiceGroupDetail: isInvoiceGroup ? _providerHistories.invoiceGroupDetail : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
