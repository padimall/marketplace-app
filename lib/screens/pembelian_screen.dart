import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/models/post_show_user_invoice_list.dart';
import 'package:padimall_app/providers/histories.dart';
import 'package:padimall_app/screens/detail_pembelian.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/invoice/invoice_summary.dart';
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
            String _statusInvoice = null;
            switch (_providerHistories.selectedStagePembelianIndex) {
              case 0:
                _statusInvoice = null;
                break;
              case 1:
                _statusInvoice = "0";
                break;
              case 2:
                _statusInvoice = "1";
                break;
              case 3:
                _statusInvoice = "2";
                break;
              case 4:
                _statusInvoice = "3";
                break;
            }
            List<InvoiceSummary> _listInvoice = [];
            if (_statusInvoice != null) {
              _listInvoice = _providerHistories.listInvoiceSummaries.where((element) => element.status == _statusInvoice).toList();
            } else {
              _listInvoice.addAll(_providerHistories.listInvoiceSummaries);
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
                      child: _listInvoice.length > 0
                          ? ListView.builder(
                              itemCount: _listInvoice.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, DetailPembelianScreen.routeName);
                                  },
                                  child: InvoiceSummaryWidget(
                                    invoiceSummary: _listInvoice[index],
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
