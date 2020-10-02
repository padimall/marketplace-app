import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/screens/info_toko_screen.dart';
import 'package:padimall_app/screens/penjualan_screen.dart';
import 'package:padimall_app/screens/produk_anda_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/akun/list_tile.dart';
import 'package:provider/provider.dart';
import 'package:padimall_app/utils/global.dart' as global;

class TokoSayaWidget extends StatelessWidget {
  ProviderToko _providerToko;

  @override
  Widget build(BuildContext context) {
    _providerToko = Provider.of<ProviderToko>(context, listen: false);

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
                  child: _providerToko.supplierDetail.imageUrl == null
                      ? Image.asset(
                          'assets/images/no_image.png',
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          imageUrl: '${_providerToko.supplierDetail.imageUrl}',
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
                  '${_providerToko.supplierDetail.name}',
                  style: PadiMallTextTheme.sz14weight600(context),
                ),
                subtitle: Text('${_providerToko.supplierDetail.address}'),
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
