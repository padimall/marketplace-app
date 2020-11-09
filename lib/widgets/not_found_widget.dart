import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class BuildNotFoundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: SvgPicture.asset(
            'assets/images/empty.svg',
            height: 100,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Kategori ini belum memiliki barang',
                  style: PadiMallTextTheme.sz14weight500(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
