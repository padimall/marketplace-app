import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/models/post_show_user_invoice_list.dart';
import 'package:padimall_app/providers/histories.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/review_product/product.dart';
import 'package:provider/provider.dart';

class ReviewProductScreen extends StatelessWidget {
  static final routeName = 'review-product-screen';

  ProviderHistories _providerHistories;
  List<ProductInvoice> _listProductInvoice = [];
  var _formRating = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _listProductInvoice = ModalRoute.of(context).settings.arguments;
    _providerHistories = Provider.of(context, listen: false);
    _providerHistories.clearRatingProductList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Beri Ulasan',
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
        actions: [
          FlatButton(
            onPressed: () {
              if (_providerHistories.isAllProductHaveRateAlready()) {
                if (_formRating.currentState.validate()) {
                  _providerHistories.postProductReview(context);
                } else {
                  Fluttertoast.showToast(msg: "Mohon lengkapi deskripsi ulasan.", backgroundColor: Theme.of(context).accentColor);
                }
              } else {
                Fluttertoast.showToast(msg: "Mohon berikan penilaian.", backgroundColor: Theme.of(context).accentColor);
              }
            },
            child: Text(
              'Kirim',
              style: PadiMallTextTheme.sz14weight600Red(context),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formRating,
          child: Column(
            children: [
              ListView.builder(
                itemCount: _listProductInvoice.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var _product = _listProductInvoice[index];
                  _providerHistories.addProductInvoiceToRatingProductList(_product);

                  return ProductForReviewWidget(
                    productInvoice: _product,
                    index: index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
