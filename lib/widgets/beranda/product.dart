import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_products.dart';
import 'package:padimall_app/screens/product_detail_screen.dart';
import 'package:padimall_app/utils/custom_image_url.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:padimall_app/utils/global.dart' as global;

class ProductWidget extends StatelessWidget {
  Product product;

  ProductWidget({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(0, 1),
          )
        ],
      ),
      margin: const EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: product);
          },
          child: GridTile(
            child: product.images.length >= 1
                ? CachedNetworkImage(
                    imageUrl: product.images[0].url,
                    placeholder: (ctx, url) => Image.asset('assets/images/logo.png'),
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/no_image.png',
                    fit: BoxFit.cover,
                  ),
            footer: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${product.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: PadiMallTextTheme.sz13weight600(context),
                  ),
                  Text(
                    'Rp ${textNumberFormatter(product.price.toDouble())}',
                    style: PadiMallTextTheme.sz12weight500(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
