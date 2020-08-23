import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BerandaCarousel extends StatelessWidget {
  List<String> _listDummy;

  @override
  Widget build(BuildContext context) {
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
