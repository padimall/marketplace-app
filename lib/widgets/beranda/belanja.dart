import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/beranda/product.dart';

class BerandaBelanja extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            'Mari Belanja',
            style: PadiMallTextTheme.sz16weight700(context),
            textAlign: TextAlign.left,
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
            ),
            itemCount: 10,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) => Product(),
          ),
        ],
      ),
    );
  }
}
