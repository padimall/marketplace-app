import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/models/order.dart';
import 'package:padimall_app/providers/cart.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:provider/provider.dart';

class KeranjangProdukWidget extends StatefulWidget {
  Order order;

  KeranjangProdukWidget({this.order});

  @override
  _KeranjangProdukWidgetState createState() => _KeranjangProdukWidgetState();
}

class _KeranjangProdukWidgetState extends State<KeranjangProdukWidget> {
  bool _isOverStock = false;

  MoneyMaskedTextController quantityController = MoneyMaskedTextController(thousandSeparator: '.', precision: 0, decimalSeparator: '');

  FocusNode focusNode;

  ProviderCart _providerCart;

  @override
  void initState() {
    super.initState();
    quantityController.text = widget.order.quantity.toString();
    var quantityItem = int.parse(quantityController.text);
    focusNode = new FocusNode();

    // focusNode listener
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          if (quantityController.text == "") {
            quantityItem = 0;
          } else {
            quantityItem = int.parse(quantityController.text);
          }
          print('berapa: ${quantityItem}');
          if (quantityItem <= widget.order.stock) {
            _isOverStock = false;
            if (quantityItem > 0) {
              if (quantityItem != widget.order.quantity) {
                _providerCart.updateCartQty(context, widget.order.cartId, quantityItem);
              }
            } else {
              CustomAlertDialog.dialogOfTwo(context, true, 'Hapus barang?', 'Yakin hapus?', 'Hapus', 'Batal', () {
                _providerCart.deleteProductFromCart(context, widget.order.cartId);
                Navigator.pop(context);
              }, () {
                Navigator.pop(context);
              });
            }
          } else {
            _isOverStock = true;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _providerCart = Provider.of(context, listen: false);

    if (_isOverStock) {
      quantityController.text = widget.order.stock.toString();
    }

    return Container(
      margin: const EdgeInsets.only(top: 16),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Checkbox(
            value: widget.order.isSelected == null ? false : widget.order.isSelected,
            onChanged: (value) {
              _providerCart.updateSelectionCartByCartId(widget.order.cartId, value);
            },
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      '${widget.order.urlPicture}',
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
                          GestureDetector(
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.delete,
                                color: Colors.grey[500],
                              ),
                            ),
                            onTap: () {
                              CustomAlertDialog.dialogOfTwo(context, true, 'Hapus dari keranjang?',
                                  'Apakah anda hendak mengeluarkan barang ini dari keranjang anda?', 'Keluarkan', 'Batal', () {
                                Navigator.pop(context);
                                _providerCart.deleteProductFromCart(context, widget.order.cartId);
                              }, () {
                                Navigator.pop(context);
                              });
                            },
                          ),
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
                              focusNode: focusNode,
                              onChanged: (value) {
                                if (value == "") {
                                  quantityController.text = "0";
                                }
                              },
                              // onFieldSubmitted: (value) {
                              //   value = value.replaceAll('.', ''); // remove delimiter
                              //   if (int.parse(value) <= widget.order.stock) {
                              //     print('false');
                              //     _isOverStock = false;
                              //
                              //     try {
                              //       // Update itemQty in cart if Qty > 0
                              //       if (int.parse(value) > 0) {
                              //         _providerCart.updateCartQty(context, widget.order.cartId, int.parse(value));
                              //       } else {
                              //
                              //       }
                              //     } catch (e) {
                              //       Fluttertoast.showToast(msg: "Invalid quantity", backgroundColor: Theme.of(context).accentColor);
                              //     }
                              //
                              //   } else {
                              //     print('true');
                              //     _isOverStock = true;
                              //   }
                              //   setState(() {});
                              // },
                            ),
                          ),
                          // Text(
                          //   'kilo',
                          //   style: PadiMallTextTheme.sz12weight500Grey(context),
                          // ),
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
