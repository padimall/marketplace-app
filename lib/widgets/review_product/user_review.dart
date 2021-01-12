import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:padimall_app/models/post_show_products.dart';
import 'package:padimall_app/models/post_show_user_invoice_list.dart';
import 'package:padimall_app/models/rating_product.dart';
import 'package:padimall_app/providers/histories.dart';
import 'package:padimall_app/screens/product_detail_screen.dart';
import 'package:padimall_app/utils/custom_logic.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:provider/provider.dart';

class UserReview extends StatelessWidget {
  RatingProduct reviewProduct;

  UserReview({this.reviewProduct});

  bool isNameHidden = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: new BoxDecoration(
        color: Colors.white70,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(4.0),
          topRight: const Radius.circular(4.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 15,
              child: Text(
                '${reviewProduct.name.substring(0, 1)}',
                style: PadiMallTextTheme.sz14weight700White(context),
              ),
              backgroundColor: Theme.of(context).accentColor,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${reviewProduct.showName == 1 ? reviewProduct.name : CustomLogic.censoredNameFormatter(reviewProduct.name)}',
                  style: PadiMallTextTheme.sz14weight500(context),
                ),
                RatingBar(
                  initialRating: reviewProduct.star.toDouble(),
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 15,
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
                  margin: const EdgeInsets.only(top: 4),
                  child: Text(
                    '${reviewProduct.description}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: PadiMallTextTheme.sz12weight500(context),
                  ),
                ),
                if (reviewProduct.images.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1 / 1,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: reviewProduct.images.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: FadeInImage.assetNetwork(
                            image: '${reviewProduct.images[index].url}',
                            fit: BoxFit.cover,
                            placeholder: 'assets/images/logo.png',
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
