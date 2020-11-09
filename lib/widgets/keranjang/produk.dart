import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:padimall_app/models/order.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';

class KeranjangProdukWidget extends StatelessWidget {
  Order order;

  KeranjangProdukWidget({this.order});

  final quantityController = MoneyMaskedTextController(
      thousandSeparator: '.', precision: 0, decimalSeparator: '');

  @override
  Widget build(BuildContext context) {
    quantityController.text = order.quantity.toString();

    return Container(
      margin: const EdgeInsets.only(top: 16),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Checkbox(
            value: true,
            onChanged: (value) {},
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      'assets/images/bawang.jpg',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          '${order.name}',
                          style: PadiMallTextTheme.sz12weight600(context),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Rp ${textNumberFormatter(order.price.toDouble())}',
                          style: PadiMallTextTheme.sz12weight600Red(context),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Jumlah: ',
                            style: PadiMallTextTheme.sz12weight500Grey(context),
                          ),
                          Container(
                            width: 50,
                            child: TextFormField(
                              decoration: InputDecoration(
                                isDense: true,
                              ),
                              textAlign: TextAlign.center,
                              style: PadiMallTextTheme.sz13weight500(context),
                              keyboardType: TextInputType.number,
                              controller: quantityController,
                            ),
                          ),
                          Text(
                            'kilo',
                            style: PadiMallTextTheme.sz12weight500Grey(context),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
