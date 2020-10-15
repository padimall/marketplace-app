import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/providers/products.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/screens/produk_tambah_screen.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/akun/product_in_row.dart';
import 'package:padimall_app/widgets/produk_anda/product_agent.dart';
import 'package:padimall_app/widgets/produk_anda/product_supplier.dart';
import 'package:provider/provider.dart';

class ProdukAndaScreen extends StatelessWidget {
  static final routeName = 'produk-anda-screen';
  ProviderProduct _providerProduct;
  ProviderToko _providerToko;

  @override
  Widget build(BuildContext context) {
    _providerProduct = Provider.of<ProviderProduct>(context, listen: false);
    _providerToko = Provider.of<ProviderToko>(context, listen: false);

    print('oi: ${_providerToko.agentDetail}');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Produk Anda',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 15,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProdukTambahScreen.routeName);
              },
              child: Icon(
                Icons.add,
                size: 25,
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.search,
                    size: 15,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffix: Icon(
                        Icons.clear,
                        size: 15,
                      ),
                      hintText: 'Cari nama produk anda',
                      hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _providerToko.agentDetail != null ? ProdukAndaAgentWidget() : ProdukAndaSupplierWidget(),
    );
  }
}
