import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/models/post_show_product_categories.dart';
import 'package:padimall_app/models/post_show_products.dart';
import 'package:padimall_app/providers/product_categories.dart';
import 'package:padimall_app/providers/products.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/beranda/product.dart';
import 'package:padimall_app/widgets/review_product/user_review.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
            builder: (ctx, provider, _) => Column(
              children: [
                _buildRatingSummaryWidget(context, product),
                Padding(
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

                          return UserReview(
                            reviewProduct: productRating,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingSummaryWidget(BuildContext context, Product product) {
    var numberOf1Star = providerProduct.listProductRatings.where((element) => element.star == 1).toList();
    var numberOf2Star = providerProduct.listProductRatings.where((element) => element.star == 2).toList();
    var numberOf3Star = providerProduct.listProductRatings.where((element) => element.star == 3).toList();
    var numberOf4Star = providerProduct.listProductRatings.where((element) => element.star == 4).toList();
    var numberOf5Star = providerProduct.listProductRatings.where((element) => element.star == 5).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: new BorderRadius.only(
          bottomLeft: const Radius.circular(10.0),
          bottomRight: const Radius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 4),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${product.ratingSummary.averageStar.toStringAsPrecision(2)}',
                        style: PadiMallTextTheme.sz24weight700(context),
                      ),
                      TextSpan(
                        text: '/5.0',
                        style: PadiMallTextTheme.sz12weight500(context),
                      )
                    ],
                  ),
                ),
              ),
              RatingBar(
                initialRating: product.ratingSummary.averageStar,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 16,
                itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                ratingWidget: RatingWidget(
                  empty: Icon(
                    Icons.star_border,
                    color: Colors.grey,
                  ),
                  half: Icon(
                    Icons.star_half,
                    color: Colors.amber,
                  ),
                  full: Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 4),
                child: Text(
                  '(${product.ratingSummary.totalRatings} ulasan)',
                  style: PadiMallTextTheme.sz13weight500Grey(context),
                ),
              ),
            ],
          ),
          Container(
            height: 80,
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            child: VerticalDivider(
              thickness: 0.5,
              width: 1.0,
              color: Colors.grey[500],
            ),
          ),
          Column(
            children: [
              _buildRatingBar(context, 5.0, numberOf5Star.length, providerProduct.listProductRatings.length),
              _buildRatingBar(context, 4.0, numberOf4Star.length, providerProduct.listProductRatings.length),
              _buildRatingBar(context, 3.0, numberOf3Star.length, providerProduct.listProductRatings.length),
              _buildRatingBar(context, 2.0, numberOf2Star.length, providerProduct.listProductRatings.length),
              _buildRatingBar(context, 1.0, numberOf1Star.length, providerProduct.listProductRatings.length),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(BuildContext context, double starIndex, int countCertainStarRating, int totalRating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RatingBar(
          initialRating: starIndex,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 14,
          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
          ratingWidget: RatingWidget(
            empty: Icon(
              Icons.star,
              color: Colors.grey[300],
            ),
            half: Icon(
              Icons.star_half,
              color: Colors.amber,
            ),
            full: Icon(
              Icons.star,
              color: Colors.amber,
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: LinearPercentIndicator(
            width: 130,
            lineHeight: 6.0,
            percent: countCertainStarRating/totalRating,
            backgroundColor: Colors.grey[300],
            progressColor: Theme.of(context).accentColor,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8),
          child: Text(
            '$countCertainStarRating',
            style: PadiMallTextTheme.sz13weight500Grey(context),
          ),
        )
      ],
    );
  }
}
