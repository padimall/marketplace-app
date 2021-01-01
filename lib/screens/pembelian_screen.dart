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

  int _invoiceCounter = 0;

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
        _providerHistories.getBuyerInvoiceHistories(context),
        Consumer<ProviderHistories>(
          builder: (ctx, provider, _) {
            _invoiceCounter = 0; // count how many invoices matched the filter

            int _statusInvoice;
            switch (_providerHistories.selectedStagePembelianIndex) {
              case 0:
                // Semua Pesanan
                _statusInvoice = null;
                break;
              case 1:
                // Belum Dibayar
                _statusInvoice = 0;
                break;
              case 2:
                // Dikemas
                _statusInvoice = 1;
                break;
              case 3:
                // Dikirim
                _statusInvoice = 2;
                break;
              case 4:
                // Pesanan Selesai
                _statusInvoice = 3;
                break;
              case 5:
                // Pesanan Dibatalkan
                _statusInvoice = 4;
                break;
              default:
                // Pesanan Dibatalkan
                _statusInvoice = null;
                break;
            }

            List<InvoiceGroup> _listInvoiceGroup = [];
            if (_statusInvoice != null) {
              // If view certain status
              if (_statusInvoice == 0) {
                // If view at status 0, view invoice group that Waiting for Payment
                _listInvoiceGroup = _providerHistories.listInvoiceSummaries.where((element) => element.status == 0).toList();
              } else {
                // View invoice group that has invoice with certain status as filtered
                for (final invoiceGroup in _providerHistories.listInvoiceSummaries) {
                  for (final invoice in invoiceGroup.invoices) {
                    if (invoice.status == _statusInvoice.toString()) {
                      _listInvoiceGroup.add(invoiceGroup);
                      break;
                    }
                  }
                }
              }
            } else {
              // If no filter, Take all invoices
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
                                List<InvoiceSummary> _listInvoice = [];

                                if (_statusInvoice == null) {
                                  // If there is view all invoices
                                  _listInvoice = _listInvoiceGroup[index].invoices;
                                } else {
                                  // If view to certain status
                                  _listInvoice = _listInvoiceGroup[index].invoices.where((element) => element.status == _statusInvoice.toString()).toList();
                                }

                                if (_listInvoiceGroup[index].status == 0) _invoiceCounter++;

                                return _listInvoiceGroup[index].status == 0
                                    ? GestureDetector(
                                        onTap: () {
                                          // Go to invoice detail by invoiceGroupId
                                          Navigator.pushNamed(context, DetailPembelianScreen.routeName,
                                              arguments: {'is_invoice_group': true, 'invoice_id': _listInvoiceGroup[index].id});
                                        },
                                        child: InvoiceSummaryByGroupWidget(
                                          invoiceGroup: _listInvoiceGroup[index],
                                          role: "buyer",
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: _listInvoice.length,
                                        // itemCount: _listInvoiceGroup[index].invoices.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (ctx, indexInvoice) {
                                          _invoiceCounter++;
                                          var invoice = _listInvoice[indexInvoice];
                                          // var invoice = _listInvoiceGroup[index].invoices[indexInvoice];

                                          return GestureDetector(
                                            onTap: () {
                                              // Go to invoice detail by invoiceId
                                              Navigator.pushNamed(context, DetailPembelianScreen.routeName,
                                                  arguments: {'is_invoice_group': false, 'invoice_id': invoice.id});
                                            },
                                            child: InvoiceSummaryByInvoiceWidget(
                                              invoiceSummary: invoice,
                                              role: "buyer",
                                            ),
                                          );
                                        },
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
                  ),
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
