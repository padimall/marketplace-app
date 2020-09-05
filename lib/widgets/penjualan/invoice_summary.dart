import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class PenjualanInvoiceSummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'INV/20200825/XX/VIII/123456',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '09 Sep 2020',
                        style:
                            TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            'assets/images/bawang.jpg',
                            height: 65,
                            width: 65,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Bawang Putih',
                              overflow: TextOverflow.ellipsis,
                              style: PadiMallTextTheme.sz13weight600(context),
                            ),
                            Text(
                              '200 Kg',
                              overflow: TextOverflow.ellipsis,
                              style: PadiMallTextTheme.sz11weight500Grey(context),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Total Pesanan: ',
                          style: PadiMallTextTheme.sz12weight600Soft(context),
                        ),
                        Text(
                          'Rp2.000.000',
                          style: PadiMallTextTheme.sz12weight600Red(context),
                        ),
                      ],
                    )),
                Container(
                  color: Theme.of(context).accentColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Pesanan Selesai',
                      textAlign: TextAlign.center,
                      style: PadiMallTextTheme.sz11weight700White(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
