import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:padimall_app/models/post_show_checkout_info.dart';
import 'package:padimall_app/providers/cart.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/show_modal_bottom.dart';
import 'package:provider/provider.dart';

class CheckoutPembayaranWidget extends StatelessWidget {
  ProviderCart _providerCart;

  CheckoutDetail checkoutDetail;

  CheckoutPembayaranWidget({this.checkoutDetail});

  @override
  Widget build(BuildContext context) {
    _providerCart = Provider.of(context, listen: false);

    Widget _buildListTilePembayaran(Payment payment, PaymentMethod paymentMethod) {
      String assetFileName = 'assets/images/payments/';

      switch (paymentMethod.name) {
        case 'OVO':
          assetFileName += 'ovo.png';
          break;
        case 'DANA':
          assetFileName += 'dana.png';
          break;
        case 'LINKAJA':
          assetFileName += 'linkaja.png';
          break;
        case 'MANDIRI':
          assetFileName += 'mandiri.png';
          break;
        case 'BRI':
          assetFileName += 'bri.png';
          break;
        case 'BNI':
          assetFileName += 'bni.png';
          break;
        case 'PERMATA':
          assetFileName += 'permata.png';
          break;
        case 'BCA':
          assetFileName += 'bca.png';
          break;
        case 'ALFAMART':
          assetFileName += 'alfamart.png';
          break;
        default:
          assetFileName += 'no_image.png';
          break;
      }

      return InkWell(
        onTap: () {
          _providerCart.setSelectedPayment(paymentMethod);
          Navigator.pop(context);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20, right: 16, top: 12, bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 12),
                child: Image.asset(
                  '$assetFileName',
                  width: payment.type == "EWALLET" ? 25 : 35,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                '${paymentMethod.name}',
                style: PadiMallTextTheme.sz14weight600(context),
              ),
            ],
          ),
        ),
      );
    }

    void showMetodePembayaran() {
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
                        'Pilih Metode Pembayaran',
                        style: PadiMallTextTheme.sz14weight600(context),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  itemCount: _providerCart.checkoutDetail.payments.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    var payment = _providerCart.checkoutDetail.payments[index];
                    return ExpansionTile(
                      title: Text(
                        '${payment.type}',
                        style: PadiMallTextTheme.sz14weight500(context),
                      ),
                      childrenPadding: EdgeInsets.symmetric(vertical: 0),
                      children: [
                        ListView.builder(
                          itemCount: payment.methods.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var paymentMethod = payment.methods[index];

                            return _buildListTilePembayaran(payment, paymentMethod);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        showMetodePembayaran();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 4),
                  child: Text(
                    'Metode Pembayaran',
                    style: PadiMallTextTheme.sz12weight600(context),
                  ),
                ),
                if (_providerCart.selectedPayment == null)
                  SvgPicture.asset(
                    'assets/images/alert.svg',
                    height: 12,
                  ),
              ],
            ),
            Row(
              children: [
                _providerCart.selectedPayment == null
                    ? Text(
                        'Pilih Metode',
                        style: PadiMallTextTheme.sz12weight500Grey(context),
                      )
                    : Text(
                        '${_providerCart.selectedPayment.name}',
                        style: PadiMallTextTheme.sz13weight600(context),
                      ),
                Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
