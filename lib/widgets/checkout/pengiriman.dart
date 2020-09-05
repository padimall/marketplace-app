import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/show_modal_bottom.dart';

class CheckoutPengirimanWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget _buildListTileDurasiPengiriman(String title, String subtitle) {

      return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('$title', style: PadiMallTextTheme.sz14weight600(context),),
              Text('$subtitle', style: PadiMallTextTheme.sz12weight500Grey(context),),
            ],
          ),
        ),
      );
    }

    void showDurasiPengiriman() {
      showBarModalBottomSheet(
        expand: false,
        context: context,
        builder: (ctx, scrollController) => Material(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close),
                        ),
                      ),
                      Text(
                        'Pilih Durasi Pengiriman',
                        style: PadiMallTextTheme.sz14weight600(context),
                      ),
                    ],
                  ),
                ),
                _buildListTileDurasiPengiriman('Reguler (2-4 hari)', 'Rp37.000'),
                _buildListTileDurasiPengiriman('Reguler (4-5 hari)', 'Rp30.000'),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 4),
                child: Text(
                  'Durasi pengiriman',
                  style: PadiMallTextTheme.sz11weight600(context),
                ),
              ),
              SvgPicture.asset(
                'assets/images/alert.svg',
                height: 12,
              ),
            ],
          ),
          Container(
            height: 30,
            child: RaisedButton(
              onPressed: () {
//                PadiMallShowModalBottom.showDurasiPengiriman(context);
                showDurasiPengiriman();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Theme.of(context).primaryColor,
              child: Text(
                'Pilih',
                style: PadiMallTextTheme.sz11weight700White(context),
              ),
            ),
          )
        ],
      ),
    );
  }
}
