import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/screens/product_detail_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class Product extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductDetailScreen.routeName);
          },
          child: GridTile(
            child: CachedNetworkImage(
              imageUrl:
                  'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
              fit: BoxFit.cover,
            ),
            footer: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Nama Produk',
                    style: PadiMallTextTheme.sz13weight600(context),
                  ),
                  Text(
                    'Rp 20.000',
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
