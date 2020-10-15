import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/providers/products.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/screens/produk_tambah_screen.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/akun/product_in_row.dart';
import 'package:provider/provider.dart';

class ProdukAndaAgentWidget extends StatelessWidget {
  ProviderProduct _providerProduct;

  @override
  Widget build(BuildContext context) {
    _providerProduct = Provider.of<ProviderProduct>(context, listen: false);

    return buildFutureBuilder(
      _providerProduct.getAgentProduct(),
      Consumer<ProviderProduct>(
        builder: (ctx, provider, _) => SingleChildScrollView(
          child: _providerProduct.listSupplierProducts != null
              ? ListView.builder(
                  itemCount: _providerProduct.listSupplierProducts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return ProductInRow(
                      product: _providerProduct.listSupplierProducts[index],
                    );
                  },
                )
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: SvgPicture.asset(
                          'assets/images/empty.svg',
                          height: 200,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          'Toko anda masih belum memiliki produk untuk dijual. Yuk kita tambahkan',
                          textAlign: TextAlign.center,
                          style: PadiMallTextTheme.sz14weight500(context),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ProdukTambahScreen.routeName);
                        },
                        child: Text(
                          'Tambah Produk',
                          style: PadiMallTextTheme.sz14weight700White(context),
                        ),
                        color: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
