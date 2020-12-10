import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/models/post_show_product_categories.dart';
import 'package:padimall_app/models/post_show_products.dart';
import 'package:padimall_app/providers/product_categories.dart';
import 'package:padimall_app/providers/products.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/custom_image_url.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/text_number_formatter.dart';
import 'package:provider/provider.dart';

class ProdukViewOnlyScreen extends StatelessWidget {
  ProviderProductCategories _providerProductCategories;
  ProviderProduct _providerProduct;
  ProductCategory _selectedProductCategory;
  static final routeName = 'produk-view-only-screen';
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = MoneyMaskedTextController(thousandSeparator: '.', precision: 0, decimalSeparator: '');
  final weightController = MoneyMaskedTextController(thousandSeparator: '.', precision: 0, decimalSeparator: '');
  final minOrderController = MoneyMaskedTextController(thousandSeparator: '.', precision: 0, decimalSeparator: '');
  final stockController = MoneyMaskedTextController(thousandSeparator: '.', precision: 0, decimalSeparator: '');

  @override
  Widget build(BuildContext context) {
    _providerProductCategories = Provider.of(context, listen: false);
    _providerProduct = Provider.of(context, listen: false);
    final Product product = ModalRoute.of(context).settings.arguments;
    nameController.text = product.name;
    descController.text = product.description;
    priceController.text = product.price.toString();
    weightController.text = product.weight.toString();
    minOrderController.text = product.minOrder.toString();
    stockController.text = product.stock.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lihat Produk',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 15,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: buildFutureBuilder(
        _providerProductCategories.getProductCategories(),
        Consumer<ProviderProductCategories>(
          builder: (ctx, provider, _) {
            _providerProductCategories.listProductCategories.forEach((element) {
              if (element.id == product.category) {
                _selectedProductCategory = element;
              }
            });

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildProductPicture(context, product),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              'Nama Produk',
                              style: PadiMallTextTheme.sz12weight500(context),
                            ),
                          ),
                          Text(
                            '${nameController.text}',
                            style: PadiMallTextTheme.sz13weight600Soft(context),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              'Kategori Produk',
                              style: PadiMallTextTheme.sz12weight500(context),
                            ),
                          ),
                          Text(
                            '${_selectedProductCategory.name}',
                            style: PadiMallTextTheme.sz13weight600Soft(context),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              'Harga Produk',
                              style: PadiMallTextTheme.sz12weight500(context),
                            ),
                          ),
                          Text(
                            'Rp ${textNumberFormatter(product.price.toDouble())}',
                            style: PadiMallTextTheme.sz13weight600Soft(context),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              'Deskripsi Produk',
                              style: PadiMallTextTheme.sz12weight500(context),
                            ),
                          ),
                          Text(
                            '${descController.text}',
                            style: PadiMallTextTheme.sz13weight600Soft(context),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              'Berat Produk (kilogram)',
                              style: PadiMallTextTheme.sz12weight500(context),
                            ),
                          ),
                          Text(
                            '${textNumberFormatter(product.weight.toDouble())}',
                            style: PadiMallTextTheme.sz13weight600Soft(context),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              'Pemesanan minimum',
                              style: PadiMallTextTheme.sz12weight500(context),
                            ),
                          ),
                          Text(
                            '${textNumberFormatter(product.minOrder.toDouble())}',
                            style: PadiMallTextTheme.sz13weight600Soft(context),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              'Stok',
                              style: PadiMallTextTheme.sz12weight500(context),
                            ),
                          ),
                          Text(
                            '${textNumberFormatter(product.stock.toDouble())}',
                            style: PadiMallTextTheme.sz13weight600Soft(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductPicture(BuildContext context, Product product) {
    return Consumer<ProviderProduct>(
      builder: (ctx, provider, _) => Container(
        margin: const EdgeInsets.fromLTRB(0, 16, 0, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Gambar Produk',
                style: PadiMallTextTheme.sz12weight600(context),
              ),
            ),
            Container(
              width: double.infinity,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: product.images.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) => Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          '${product.images[index].url}',
                          height: 75,
                          width: 75,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
