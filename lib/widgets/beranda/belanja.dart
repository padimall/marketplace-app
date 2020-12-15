import 'package:flutter/material.dart';
import 'package:padimall_app/providers/products.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/beranda/product.dart';
import 'package:provider/provider.dart';

class BerandaBelanja extends StatelessWidget {
  ProviderProduct _productState;

  @override
  Widget build(BuildContext context) {
    _productState = Provider.of(context, listen: false);
    print('masuk lagi');

    return buildFutureBuilder(
      _productState.getProducts(),
      Consumer<ProviderProduct>(
        builder: (ctx, provider, _) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Mari Belanja',
                  style: PadiMallTextTheme.sz16weight700(context),
                  textAlign: TextAlign.left,
                ),
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                ),
                itemCount: _productState.listProduct.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) => ProductWidget(product: _productState.listProduct[index],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
