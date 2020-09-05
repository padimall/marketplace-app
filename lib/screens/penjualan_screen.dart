import 'package:flutter/material.dart';
import 'package:padimall_app/providers/histories.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/penjualan/invoice_summary.dart';
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
      body: Consumer<ProviderHistories>(
        builder: (ctx, provider, _) => Container(
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
                          hintStyle:
                              PadiMallTextTheme.sz14weight500Grey(context),
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
                    _buildStagingChip(context, 'Pesanan Baru', 1),
                    _buildStagingChip(context, 'Siap Dikirim', 2),
                    _buildStagingChip(context, 'Dalam Pengiriman', 3),
                    _buildStagingChip(context, 'Pesanan Selesai', 4),
                    _buildStagingChip(context, 'Pesanan Dibatalkan', 5),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return PenjualanInvoiceSummaryWidget();
                  },
                ),
              )
            ],
          ),
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
          style: PadiMallTextTheme.sz12weight500(context)
              .copyWith(color: textColor),
        ),
      ),
    );
  }
}
