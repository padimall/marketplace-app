import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/providers/banners.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:provider/provider.dart';

class BerandaCarousel extends StatefulWidget {
  @override
  _BerandaCarouselState createState() => _BerandaCarouselState();
}

class _BerandaCarouselState extends State<BerandaCarousel> {
  ProviderBanner _providerBanner;

  @override
  Widget build(BuildContext context) {
    _providerBanner = Provider.of<ProviderBanner>(context, listen: false);

    return buildFutureBuilder(
      _providerBanner.getBannerList(context),
      Consumer<ProviderBanner>(
        builder: (ctx, provider, _) => ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            _providerBanner.listBanner.isEmpty
                ? Container()
                : new Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 2,
                    child: Carousel(
                      boxFit: BoxFit.cover,
                      images: _providerBanner.listBanner
                          .map((banner) => Image.network(
                                banner.image,
                                fit: BoxFit.cover,
                              ))
                          .toList(),
                      autoplay: true,
                      autoplayDuration: Duration(seconds: 2),
                      dotSize: 4,
                      indicatorBgPadding: 4,
                      dotBgColor: Theme.of(context).accentColor.withOpacity(0.5),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
