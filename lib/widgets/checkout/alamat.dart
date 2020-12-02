import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_user_profile.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class CheckoutAlamatWidget extends StatelessWidget {
  UserProfileDetail userProfileDetail;

  CheckoutAlamatWidget({this.userProfileDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Alamat Pengiriman',
                style: PadiMallTextTheme.sz13weight600(context),
              ),
              // Text(
              //   'Pilih alamat lain',
              //   style: PadiMallTextTheme.sz13weight600Green(context),
              // ),
            ],
          ),
          Divider(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: Text(
              '${userProfileDetail.address}',
              style: PadiMallTextTheme.sz12weight600(context),
            ),
          ),
          Text(
            '${userProfileDetail.name} (${userProfileDetail.phone})',
            style: PadiMallTextTheme.sz11weight500Grey(context),
          ),
        ],
      ),
    );
  }
}
