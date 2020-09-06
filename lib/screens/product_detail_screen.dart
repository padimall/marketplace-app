import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/screens/checkout_screen.dart';
import 'package:padimall_app/screens/keranjang_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class ProductDetailScreen extends StatelessWidget {
  static final routeName = 'product-detail-screen';

  @override
  Widget build(BuildContext context) {

    Widget _carouselImages = new Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          CachedNetworkImage(imageUrl: 'https://cdn.pixabay.com/photo/2013/02/04/22/47/fruits-77946_1280.jpg', fit: BoxFit.cover,),
          CachedNetworkImage(imageUrl: 'https://cdn.pixabay.com/photo/2017/01/03/01/13/vegetables-1948264_1280.jpg', fit: BoxFit.cover,),
          CachedNetworkImage(imageUrl: 'https://cdn.pixabay.com/photo/2015/07/27/22/58/life-863705_1280.jpg', fit: BoxFit.cover,),
        ],
        autoplay: true,
        autoplayDuration: Duration(seconds: 2),
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
          'Bawang Putih',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      _carouselImages
                    ],
                  ),
//                  Container(
//                    color: Colors.grey[300],
//                    height: 200,
//                  ),
                  NamaHargaProduk(),
                  SizedBox(
                    height: 8,
                  ),
                  InfoProduk(),
                  SizedBox(
                    height: 8,
                  ),
                  InfoToko(),
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
                      onPressed: () {
                        Navigator.pushNamed(context, KeranjangScreen.routeName);
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
                      onPressed: () {
                        Navigator.pushNamed(context, CheckoutScreen.routeName);
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
  const NamaHargaProduk({
    Key key,
  }) : super(key: key);

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
            'Bawang Putih',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: PadiMallTextTheme.sz16weight700(context),
          ),
          Text(
            'Rp 20.000',
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
  const InfoProduk({
    Key key,
  }) : super(key: key);

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
                '1 kg',
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
                '45 kg',
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
              imageUrl:
                  'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
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
