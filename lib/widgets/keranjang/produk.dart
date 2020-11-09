import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:padimall_app/models/order.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';

class KeranjangProdukWidget extends StatefulWidget {
  Order order;

  KeranjangProdukWidget({this.order});

  @override
  _KeranjangProdukWidgetState createState() => _KeranjangProdukWidgetState();
}

class _KeranjangProdukWidgetState extends State<KeranjangProdukWidget> {
  bool _isOverStock = false;
  MoneyMaskedTextController quantityController = MoneyMaskedTextController(thousandSeparator: '.', precision: 0, decimalSeparator: '');

  @override
  void initState() {
    quantityController.text = widget.order.quantity.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isOverStock) {
      quantityController.text = widget.order.stock.toString();
    }

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
                          '${widget.order.name}',
                          style: PadiMallTextTheme.sz12weight600(context),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: Text(
                                'Rp ${textNumberFormatter(widget.order.price.toDouble())}',
                                style: PadiMallTextTheme.sz12weight600Red(context),
                              ),
                            ),
                            Text(
                              '(stock: ${textNumberFormatter(widget.order.stock.toDouble())})',
                              style: PadiMallTextTheme.sz12weight500Grey(context),
                            ),
                          ],
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
                              onChanged: (value) {
                                value = value.replaceAll('.', ''); // remove delimiter
                                if (int.parse(value) <= widget.order.stock) {
                                  print('false');
                                  _isOverStock = false;
                                } else {
                                  print('true');
                                  _isOverStock = true;
                                }
                                setState(() {});
                              },
                            ),
                          ),
                          Text(
                            'kilo',
                            style: PadiMallTextTheme.sz12weight500Grey(context),
                          ),
                          _isOverStock
                              ? Text(
                                  ' (max. order: ${textNumberFormatter(widget.order.stock.toDouble())})',
                                  style: PadiMallTextTheme.sz12weight600Red(context),
                                )
                              : Container(),
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
