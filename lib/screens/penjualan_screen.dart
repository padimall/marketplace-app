import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/models/post_show_user_invoice_list.dart';
import 'package:padimall_app/providers/histories.dart';
import 'package:padimall_app/screens/detail_penjualan.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/invoice/invoice_summary_by_group.dart';
import 'package:padimall_app/widgets/invoice/invoice_summary_by_invoice.dart';
import 'package:provider/provider.dart';

class PenjualanScreen extends StatelessWidget {
  static final routeName = 'penjualan-screen';
  ProviderHistories _providerHistories;

  @override
  Widget build(BuildContext context) {
    _providerHistories = Provider.of(context, listen: false);

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
        _providerHistories.getAgentInvoiceHistories(context),
        Consumer<ProviderHistories>(
          builder: (ctx, provider, _) {
            int _statusInvoiceSummary;
            switch (_providerHistories.selectedStagePenjualanIndex) {
              case 0:
                // Semua Pesanan
                _statusInvoiceSummary = null;
                break;
              case 1:
                // Pesanan Baru
                _statusInvoiceSummary = 1;
                break;
              case 2:
                // Dalam Pengiriman
                _statusInvoiceSummary = 2;
                break;
              case 3:
                // Pesanan Selesai
                _statusInvoiceSummary = 2;
                break;
              case 4:
                // Pesanan Dibatalkan
                _statusInvoiceSummary = 3;
                break;
              default:
                // Pesanan Dibatalkan
                _statusInvoiceSummary = null;
                break;
            }

            List<InvoiceSummary> _listInvoices = [];
            if (_statusInvoiceSummary != null) {
              _listInvoices = _providerHistories.listInvoiceSeller.where((element) => element.status == _statusInvoiceSummary.toString()).toList();
            } else {
              _listInvoices.addAll(_providerHistories.listInvoiceSeller);
            }

            return Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.search,
                            size: 15,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              suffix: Icon(
                                Icons.clear,
                                size: 15,
                              ),
                              hintText: 'Cari nama produk anda',
                              hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 16,
                        ),
                        _buildStagingChip(context, 'Semua Pesananan', 0),
                        _buildStagingChip(context, 'Pesanan Baru', 1), // Dikemas
                        _buildStagingChip(context, 'Dalam Pengiriman', 2), // Dikirim
                        _buildStagingChip(context, 'Pesanan Selesai', 3),
                        _buildStagingChip(context, 'Pesanan Dibatalkan', 4),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: _listInvoices.length > 0
                          ? ListView.builder(
                              itemCount: _listInvoices.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                var invoice = _listInvoices[index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, DetailPenjualanScreen.routeName);
                                  },
                                  child: InvoiceSummaryByInvoiceWidget(
                                    invoiceSummary: invoice,
                                  ),
                                );
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 40),
                                    child: SvgPicture.asset(
                                      'assets/images/empty.svg',
                                      height: 150,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      'Oopsie, belum ada nih transaksi dengan status demikian',
                                      textAlign: TextAlign.center,
                                      style: PadiMallTextTheme.sz14weight500(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStagingChip(BuildContext context, String buttonText, int index) {
    Color textColor;
    Color buttonColor;
    Color borderColor;

    if (_providerHistories.selectedStagePenjualanIndex == index) {
      textColor = Colors.white;
      buttonColor = Theme.of(context).primaryColor;
      borderColor = Theme.of(context).primaryColor;
    } else {
      textColor = Colors.black87;
      buttonColor = Colors.white;
      borderColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: RaisedButton(
        onPressed: () {
          _providerHistories.setSelectedStagePenjualanIndex(index);
        },
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          side: BorderSide(
            color: borderColor,
          ),
        ),
        color: buttonColor,
        child: Text(
          '$buttonText',
          style: PadiMallTextTheme.sz12weight500(context).copyWith(color: textColor),
        ),
      ),
    );
  }
}
