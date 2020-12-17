import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/models/post_show_suppliers_agent_detail.dart';
import 'package:padimall_app/providers/products.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/beranda/product.dart';
import 'package:provider/provider.dart';

class TokoProductsWidget extends StatelessWidget {
  ProviderProduct providerProduct;

  Agent agent;

  TokoProductsWidget({this.agent});

  @override
  Widget build(BuildContext context) {
    providerProduct = Provider.of(context, listen: false);
    return buildFutureBuilder(
      providerProduct.getCertainTokoProduct(context, agent.id),
      Consumer<ProviderProduct>(
        builder: (ctx, provider, _) => providerProduct.listProductAgent.isEmpty
            ? Container(
                width: double.infinity,
                color: Colors.white,
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
                        'Toko ini belum memiliki produk',
                        textAlign: TextAlign.center,
                        style: PadiMallTextTheme.sz14weight500(context),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                color: Colors.white,
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          'Semua Produk',
                          style: PadiMallTextTheme.sz14weight600(context),
                        ),
                      ),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: providerProduct.listProductAgent.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) => ProductWidget(
                          product: providerProduct.listProductAgent[index],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
