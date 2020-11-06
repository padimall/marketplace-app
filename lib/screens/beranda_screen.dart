import 'package:flutter/material.dart';
import 'package:padimall_app/providers/banners.dart';
import 'package:padimall_app/screens/product_search_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/beranda/belanja.dart';
import 'package:padimall_app/widgets/beranda/carousel.dart';
import 'package:padimall_app/widgets/beranda/kategori.dart';
import 'package:provider/provider.dart';

class BerandaScreen extends StatefulWidget {
  @override
  _BerandaScreenState createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> with TickerProviderStateMixin {
  AnimationController _colorAnimationController;

  AnimationController _textAnimationController;

  Animation<Color> _colorTween;

  Animation<Offset> _transTween;

  @override
  void initState() {
    _colorAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white).animate(_colorAnimationController);
    _textAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 0));
    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0)).animate(_textAnimationController);

    super.initState();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels / 350);
      _textAnimationController.animateTo((scrollInfo.metrics.pixels - 350) - 500);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NotificationListener<ScrollNotification>(
        onNotification: _scrollListener,
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    BerandaCarousel(),
                    BerandaKategori(),
                    BerandaBelanja(),
                  ],
                ),
              ),
              Container(
                height: 70,
                child: AnimatedBuilder(
                  animation: _colorAnimationController,
                  builder: (context, child) {
                    return AppBar(
                      backgroundColor: _colorTween.value,
                      elevation: 0,
                      titleSpacing: 0,
                      title: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ProductSearchScreen.routeName);
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          margin: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.search,
                                  size: 15,
                                ),
                              ),
                              Text(
                                'Cari nama produk anda',
                                style: PadiMallTextTheme.sz12weight500Grey(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
