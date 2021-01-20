import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/models/post_show_product_categories.dart';
import 'package:padimall_app/providers/product_categories.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/beranda/product.dart';
import 'package:provider/provider.dart';

class ProductByCategoryScreen extends StatelessWidget {
  static final routeName = 'product-by-category-screen';
  ProviderProductCategories _providerProductCategories;

  @override
  Widget build(BuildContext context) {
    _providerProductCategories = Provider.of<ProviderProductCategories>(context, listen: false);

    final ProductCategory _productCategory = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_productCategory.name}',
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
        backgroundColor: Colors.white,
      ),
      body: buildFutureBuilder(
        _providerProductCategories.getProductByCategory(_productCategory),
        Consumer<ProviderProductCategories>(
          builder: (ctx, provider, _) => _providerProductCategories.listProduct.isEmpty
              ? Container(
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
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Tidak ada ditemukannya barang dengan kategori ',
                                style: PadiMallTextTheme.sz14weight500(context),
                              ),
                              TextSpan(
                                text: '${_productCategory.name}',
                                style: PadiMallTextTheme.sz14weight600(context),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: _providerProductCategories.listProduct.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) => ProductWidget(
                            product: _providerProductCategories.listProduct[index],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
