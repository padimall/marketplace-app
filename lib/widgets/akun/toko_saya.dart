import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/screens/info_toko_screen.dart';
import 'package:padimall_app/screens/penjualan_screen.dart';
import 'package:padimall_app/screens/produk_anda_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/akun/list_tile.dart';

class TokoSayaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, InfoTokoScreen.routeName);
          },
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://cdn.pixabay.com/photo/2014/01/19/12/31/onions-248027_1280.jpg',
                    fit: BoxFit.cover,
                    placeholder: (ctx, url) => Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
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
