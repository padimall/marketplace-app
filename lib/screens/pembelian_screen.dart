import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/models/post_show_user_invoice_list.dart';
import 'package:padimall_app/providers/histories.dart';
import 'package:padimall_app/screens/detail_pembelian.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/invoice/invoice_summary_by_group.dart';
import 'package:padimall_app/widgets/invoice/invoice_summary_by_invoice.dart';
import 'package:provider/provider.dart';

class PembelianScreen extends StatelessWidget {
  static final routeName = 'pembelian-screen';
  ProviderHistories _providerHistories;

  @override
  Widget build(BuildContext context) {
    _providerHistories = Provider.of(context, listen: false);

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
        _providerHistories.getUserInvoiceHistories(context),
        Consumer<ProviderHistories>(
          builder: (ctx, provider, _) {
            int _statusInvoiceGroup;
            switch (_providerHistories.selectedStagePembelianIndex) {
              case 0:
                _statusInvoiceGroup = null;
                break;
              case 1:
                _statusInvoiceGroup = 0;
                break;
              case 2:
                _statusInvoiceGroup = 1;
                break;
              case 3:
                _statusInvoiceGroup = 2;
                break;
              case 4:
                _statusInvoiceGroup = 3;
                break;
              case 5:
                _statusInvoiceGroup = 4;
                break;
            }
            List<InvoiceGroup> _listInvoiceGroup = [];
            if (_statusInvoiceGroup != null) {
              _listInvoiceGroup = _providerHistories.listInvoiceSummaries.where((element) => element.status == _statusInvoiceGroup).toList();
            } else {
              _listInvoiceGroup.addAll(_providerHistories.listInvoiceSummaries);
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
                    margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
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
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          _buildStagingChip(context, 'Semua Pesananan', 0),
                          _buildStagingChip(context, 'Belum Dibayar', 1),
                          _buildStagingChip(context, 'Dikemas', 2),
                          _buildStagingChip(context, 'Dikirim', 3),
                          _buildStagingChip(context, 'Pesanan Selesai', 4),
                          _buildStagingChip(context, 'Pesanan Dibatalkan', 5),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: _listInvoiceGroup.length > 0
                          ? ListView.builder(
                              itemCount: _listInvoiceGroup.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, DetailPembelianScreen.routeName);
                                  },
                                  child: _listInvoiceGroup[index].status == 0
                                      ? InvoiceSummaryByGroupWidget(
                                          invoiceGroup: _listInvoiceGroup[index],
                                        )
                                      : ListView.builder(
                                          itemCount: _listInvoiceGroup[index].invoices.length,
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (ctx, indexInvoice) {
                                            var invoice = _listInvoiceGroup[index].invoices[indexInvoice];

                                            return InvoiceSummaryByInvoiceWidget(
                                              invoiceSummary: invoice,
                                            );
                                          },
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

    if (_providerHistories.selectedStagePembelianIndex == index) {
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
          _providerHistories.setSelectedStagePembelianIndex(index);
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
