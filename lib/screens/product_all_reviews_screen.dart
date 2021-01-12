import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/models/post_show_product_categories.dart';
import 'package:padimall_app/models/post_show_products.dart';
import 'package:padimall_app/providers/product_categories.dart';
import 'package:padimall_app/providers/products.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/beranda/product.dart';
import 'package:padimall_app/widgets/review_product/user_review.dart';
import 'package:provider/provider.dart';

class ProductAllReviewsScreen extends StatelessWidget {
  static final routeName = 'product-all-reviews-screen';

  ProviderProduct providerProduct;

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments;
    providerProduct = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penilaian ${product.name}',
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
      body: SingleChildScrollView(
        child: buildFutureBuilder(
          providerProduct.getProductRatings(context, product.id),
          Consumer<ProviderProduct>(
            builder: (ctx, provider, _) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ListView.builder(
                    itemCount: providerProduct.listProductRatings.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      var productRating = providerProduct.listProductRatings[index];

                      if (providerProduct.listProductRatings[index].images.isNotEmpty) {
                        print('apa tu ${providerProduct.listProductRatings[index].images[0].url}');
                      }

                      return UserReview(
                        reviewProduct: productRating,
                      );
                    },
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
