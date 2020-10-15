import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_products.dart';
import 'package:padimall_app/screens/produk_edit_screen.dart';
import 'package:padimall_app/utils/custom_image_url.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';

class ProductInRow extends StatelessWidget {
  Product product;

  ProductInRow({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: product.images.length < 1
                  ? Image.asset(
                      'assets/images/no_image.png',
                      height: 75,
                      width: 75,
                      fit: BoxFit.cover,
                    )
                  : FadeInImage.assetNetwork(
                      image: product.images[0].url,
                      placeholder: 'assets/images/logo.png',
                      height: 75,
                      width: 75,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${product.name}',
                      style: PadiMallTextTheme.sz14weight700(context),
                    ),
                    Text(
                      'Rp ${textNumberFormatter(product.price.toDouble())}',
                      style: PadiMallTextTheme.sz14weight600Red(context),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Stok ${textNumberFormatter(product.stock.toDouble())} Kg',
                    style: PadiMallTextTheme.sz12weight500Grey(context),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ProdukEditScreen.routeName, arguments: product);
                      },
                      child: Text(
                        'Ubah',
                        style: PadiMallTextTheme.sz13weight700Green(context),
                      ),
                    ),
                    product.stock == 1
                        ? Container()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              color: Theme.of(context).accentColor,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                child: Text(
                                  'In Review',
                                  style: PadiMallTextTheme.sz11weight700White(context),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
