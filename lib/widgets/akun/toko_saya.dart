import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/screens/penjualan_screen.dart';
import 'package:padimall_app/screens/produk_anda_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/akun/list_tile.dart';

class TokoSayaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                ),
              ),
              title: Text(
                'Toko Subur Selalu',
                style: PadiMallTextTheme.sz14weight600(context),
              ),
              subtitle: Text('Medan, Sumatera Utara'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
          ),
        ),
        AkunListTile(
          title: 'Produk Anda',
          subtitle: 'Lihat dan atur semua Produk Anda',
          handler: () {
            Navigator.pushNamed(context, ProdukAndaScreen.routeName);
          },
        ),
        AkunListTile(
          title: 'Riwayat Penjualan',
          subtitle: 'Berisi data riwayat penjualan Anda',
          handler: () {
            Navigator.pushNamed(context, PenjualanScreen.routeName);
          },
        ),
      ],
    );
  }
}
