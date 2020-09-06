import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/screens/product_detail_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class Product extends StatelessWidget {
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
            Navigator.pushNamed(context, ProductDetailScreen.routeName);
          },
          child: GridTile(
            child: CachedNetworkImage(
              imageUrl:
                  'https://cdn.pixabay.com/photo/2017/01/03/01/13/vegetables-1948264_1280.jpg',
              placeholder: (ctx, url) => Image.asset('assets/images/logo.png'),
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
