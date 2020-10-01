import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BerandaCarousel extends StatefulWidget {
  @override
  _BerandaCarouselState createState() => _BerandaCarouselState();
}

class _BerandaCarouselState extends State<BerandaCarousel> {
  List<String> _listDummy;

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

    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        _carouselImages
      ],
    );

    return Container(
      child: CarouselSlider(
        aspectRatio: 2.5,
        initialPage: 0,
        onPageChanged: (index) {

        },
        autoPlay: true,
        items: _listDummy.map((newsBanner) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Builder(
              builder: (BuildContext context) {
                return Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage.assetNetwork(
                        image: newsBanner,
                        placeholder: 'assets/images/icon_launcher.png',
                        placeholderCacheHeight: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
