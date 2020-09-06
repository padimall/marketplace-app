import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/beranda/belanja.dart';
import 'package:padimall_app/widgets/beranda/carousel.dart';
import 'package:padimall_app/widgets/beranda/kategori.dart';

class BerandaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              BerandaCarousel(),
              BerandaKategori(),
              BerandaBelanja(),
            ],
          ),
        ),
      ),
    );
  }
}
