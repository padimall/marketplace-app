import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_products.dart';
import 'package:padimall_app/providers/products.dart';
import 'package:padimall_app/screens/produk_edit_screen.dart';
import 'package:padimall_app/utils/custom_image_url.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:provider/provider.dart';

class YourSupplierProductInRow extends StatelessWidget {
  Product product;
  String supplierId;

  YourSupplierProductInRow({this.product, this.supplierId});

  ProviderProduct _providerProduct;

  @override
  Widget build(BuildContext context) {
    _providerProduct = Provider.of(context, listen: false);

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
                        // TODO: Navigate to Product Preview Screen
//                        Navigator.pushNamed(context, ProdukEditScreen.routeName, arguments: product);
                      },
                      child: Text(
                        'Lihat',
                        style: PadiMallTextTheme.sz13weight700Green(context),
                      ),
                    ),
                    Switch(
                      value: product.status == "1" ? true : false,
//                      value: product.stock == 1 ? true : false,
                      onChanged: (bool value) {
                        _providerProduct.updateStatusProduct(context, product, supplierId);
                      },
                    ),
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
