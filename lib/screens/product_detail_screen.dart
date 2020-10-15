import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_products.dart';
import 'package:padimall_app/screens/checkout_screen.dart';
import 'package:padimall_app/screens/first_screen.dart';
import 'package:padimall_app/screens/keranjang_screen.dart';
import 'package:padimall_app/screens/login_screen.dart';
import 'package:padimall_app/utils/custom_image_url.dart';
import 'package:padimall_app/utils/custom_logic.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:padimall_app/widgets/alert_dialog/ok.dart';

class ProductDetailScreen extends StatelessWidget {
  static final routeName = 'product-detail-screen';

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;

    Widget _carouselImages = new AspectRatio(
      aspectRatio: 1,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: product.images
            .map((productImages) => CachedNetworkImage(
                  imageUrl: productImages.url,
                  fit: BoxFit.cover,
                ))
            .toList(),
        autoplay: true,
        autoplayDuration: Duration(seconds: 4),
//        showIndicator: false,
        dotSize: 4,
        indicatorBgPadding: 4,
        dotBgColor: Theme.of(context).accentColor.withOpacity(0.5),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 15,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          '${product.name}',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  product.images.length < 1
                      ? AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset(
                            'assets/images/no_image.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      : ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[_carouselImages],
                        ),
                  NamaHargaProduk(
                    product: product,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InfoProduk(
                    product: product,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // TODO: Info Toko
//                  InfoToko(),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                blurRadius: 1.0,
                spreadRadius: 1.0,
              )
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () async {
                        if (await CustomLogic.isUserTokenExist()) {
                          Navigator.pushNamed(context, KeranjangScreen.routeName);
                        } else {
                          showAlertDialogOk(
                            context,
                            false,
                            'Yuk Sign In',
                            'Silahkan Sign In terlebih dahulu untuk menggunakan fitur ini',
                            'Sign In',
                            () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, LoginScreen.routeName);
                            },
                          );
                        }
                      },
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: Text(
                        '+ Keranjang',
                        style: PadiMallTextTheme.sz16weight700White(context),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () async {
                        if (await CustomLogic.isUserTokenExist()) {
                          Navigator.pushNamed(context, CheckoutScreen.routeName);
                        } else {
                          showAlertDialogOk(
                            context,
                            false,
                            'Yuk Sign In',
                            'Silahkan Sign In terlebih dahulu untuk menggunakan fitur ini',
                            'Sign In',
                            () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, LoginScreen.routeName);
                            },
                          );
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: Text(
                        'Beli Sekarang',
                        style: PadiMallTextTheme.sz16weight700White(context),
                      ),
                    ),
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

class NamaHargaProduk extends StatelessWidget {
  Product product;

  NamaHargaProduk({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${product.name}',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: PadiMallTextTheme.sz16weight700(context),
          ),
          Text(
            'Rp ${textNumberFormatter(product.price.toDouble())}',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: PadiMallTextTheme.sz14weight600Red(context),
          ),
        ],
      ),
    );
  }
}

class InfoProduk extends StatelessWidget {
  Product product;

  InfoProduk({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Informasi Produk',
              style: PadiMallTextTheme.sz16weight700(context),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Berat',
                style: PadiMallTextTheme.sz14weight500(context),
              ),
              Text(
                '${textNumberFormatter(product.weight.toDouble())} kg',
                style: PadiMallTextTheme.sz14weight500(context),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Pemesanan Min.',
                style: PadiMallTextTheme.sz14weight500(context),
              ),
              Text(
                '${textNumberFormatter(product.minOrder.toDouble())} kg',
                style: PadiMallTextTheme.sz14weight500(context),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Stok',
                style: PadiMallTextTheme.sz14weight500(context),
              ),
              Text(
                '${textNumberFormatter(product.stock.toDouble())} kg',
                style: PadiMallTextTheme.sz14weight500(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoToko extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
              fit: BoxFit.cover,
              height: 60,
              width: 60,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Toko Subur Selalu',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: PadiMallTextTheme.sz13weight600(context),
                  ),
                  Text(
                    'Medan, Sumatera Utara',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: PadiMallTextTheme.sz12weight500Grey(context),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
