import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:padimall_app/models/post_show_user_invoice_list.dart';
import 'package:padimall_app/providers/histories.dart';
import 'package:padimall_app/providers/products.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:provider/provider.dart';

class ProductForReviewWidget extends StatefulWidget {
  ProductInvoice productInvoice;
  int index;

  ProductForReviewWidget({this.productInvoice, this.index});

  @override
  _ProductForReviewWidgetState createState() => _ProductForReviewWidgetState();
}

class _ProductForReviewWidgetState extends State<ProductForReviewWidget> {
  ProviderHistories _providerHistories;
  int _rating;
  bool isNameHidden = false;

  @override
  void initState() {
    super.initState();
  }

  String getDescriptionHintText(int rating) {
    switch (rating) {
      case 1:
        return 'Beritahu pengguna lain mengapa produk ini tidak direkomendasikan.';
        break;
      case 2:
        return 'Beritahu pengguna lain mengapa anda tidak menyukai produk ini.';
        break;
      case 3:
        return 'Beritahu pengguna lain mengapa produk ini cukup direkomendasikan.';
        break;
      case 4:
        return 'Beritahu pengguna lain mengapa anda puas dengan produk ini.';
        break;
      case 5:
        return 'Beritahu pengguna lain mengapa anda sangat puas dengan produk ini.';
        break;
      default:
        return '';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _providerHistories = Provider.of(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.white70,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: widget.productInvoice.image == null
                      ? Image.asset(
                          'assets/images/no_image.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        )
                      : FadeInImage.assetNetwork(
                          image: '${widget.productInvoice.image}',
                          fit: BoxFit.cover,
                          placeholder: 'assets/images/logo.png',
                          height: 50,
                          width: 50,
                        ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.productInvoice.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: PadiMallTextTheme.sz13weight500(context),
                    ),
                    Text(
                      'Jumlah: ${textNumberFormatter(widget.productInvoice.quantity.toDouble())}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: PadiMallTextTheme.sz12weight500Grey(context),
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(
            height: 32,
            thickness: 1,
          ),
          RatingBar(
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating.toInt();
                _providerHistories.updateStarRatingByInvoiceProductId(widget.productInvoice.id, _rating);
              });
            },
          ),
          if (_rating != null)
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  _buildProductPicture(context, widget.index),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Tulis Ulasan',
                      hintText: '${getDescriptionHintText(_rating)}',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 5,
                    style: PadiMallTextTheme.sz14weight500(context),
                    onChanged: (value) {
                      _providerHistories.updateRatingDescriptionByInvoiceProductId(widget.productInvoice.id, value);
                    },
                    validator: (input) {
                      return input.isEmpty ? 'Kolom ini harus diisi' : null;
                    },
                    // onSaved: (input) => _email = input,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Berikan ulasan ',
                                style: PadiMallTextTheme.sz13weight500(context),
                              ),
                              TextSpan(
                                text: 'tanpa nama',
                                style: PadiMallTextTheme.sz13weight600(context),
                              )
                            ],
                          ),
                        ),
                        Switch(
                          value: isNameHidden,
                          onChanged: (value) {
                            setState(() {
                              isNameHidden = value;
                              _providerHistories.updateIsNameVisibleByInvoiceProductId(widget.productInvoice.id, isNameHidden);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductPicture(BuildContext context, int index) {
    List<File> _listProductImages = [];
    if (_providerHistories.listRatingProduct[index].images != null) _listProductImages = _providerHistories.listRatingProduct[index].images;

    return Consumer<ProviderHistories>(
      builder: (ctx, provider, _) => Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: _listProductImages.length + 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, indexImage) {
                  print(indexImage);
                  // var _productRatingImage = _listProductImages[indexImage];

                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: indexImage >= _listProductImages.length
                              ? GestureDetector(
                                  onTap: () {
                                    _providerHistories.loadAssetsPicture(indexImage, widget.productInvoice.id);
                                  },
                                  child: Image.asset(
                                    'assets/images/add_picture.png',
                                    height: 75,
                                    width: 75,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.file(
                                  _listProductImages[indexImage],
                                  height: 75,
                                  width: 75,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      indexImage < _listProductImages.length
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  _providerHistories.removeRatingProductImageByInvoiceProductId(widget.productInvoice.id, indexImage);
                                },
                                child: CircleAvatar(
                                  radius: 10,
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  backgroundColor: Colors.black87,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
