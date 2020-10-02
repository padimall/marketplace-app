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
import 'package:padimall_app/utils/custom_image_url.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:provider/provider.dart';

class ProdukEditScreen extends StatelessWidget {
  ProviderProductCategories _providerProductCategories;
  ProviderProduct _providerProduct;
  static final routeName = 'produk-edit-screen';
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = MoneyMaskedTextController(thousandSeparator: '.', precision: 0, decimalSeparator: '');
  final weightController = MoneyMaskedTextController(thousandSeparator: '.', precision: 0, decimalSeparator: '');
  final minOrderController = MoneyMaskedTextController(thousandSeparator: '.', precision: 0, decimalSeparator: '');
  final stockController = MoneyMaskedTextController(thousandSeparator: '.', precision: 0, decimalSeparator: '');
  ProductCategory _selectedProductCategory;

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
          'Edit Produk',
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
                  children: <Widget>[
                    _buildProductPicture(context, product),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Nama Produk',
                            style: PadiMallTextTheme.sz12weight600DarkGrey(context),
                          ),
                          TextFormField(
                            style: PadiMallTextTheme.sz14weight500(context),
                            decoration: InputDecoration(
                              hintText: 'Tuliskan nama produk Anda',
                              hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                              isDense: true,
                            ),
                            maxLength: 50,
                            controller: nameController,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DropdownSearch(
                            mode: Mode.BOTTOM_SHEET,
                            isFilteredOnline: true,
                            showSearchBox: true,
                            label: 'Kategori Produk',
                            autoFocusSearchBox: true,
                            dropdownSearchDecoration: InputDecoration(
                              hintText: 'Tentukan kategori produk Anda',
                              hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                              labelStyle: PadiMallTextTheme.sz12weight600DarkGrey(context),
                              contentPadding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            items: _providerProductCategories.listProductCategories,
                            itemAsString: (ProductCategory item) => item.name,
                            selectedItem: _selectedProductCategory,
                            onChanged: (ProductCategory productCategory) {
                              _selectedProductCategory = productCategory;
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Harga Produk',
                            style: PadiMallTextTheme.sz12weight600DarkGrey(context),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                child: Text('Rp'),
                              ),
                              Expanded(
                                child: TextFormField(
                                  style: PadiMallTextTheme.sz14weight500(context),
                                  decoration: InputDecoration(
                                    hintText: 'Tuliskan harga produk Anda',
                                    hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                                    isDense: true,
                                  ),
                                  keyboardType: TextInputType.number,
                                  controller: priceController,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Deskripsi',
                            style: PadiMallTextTheme.sz12weight600DarkGrey(context),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Tuliskan deskripsi produk Anda',
                              hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                            ),
                            maxLength: 50,
                            controller: descController,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Berat Produk (kilogram)',
                            style: PadiMallTextTheme.sz12weight600DarkGrey(context),
                          ),
                          TextFormField(
                            style: PadiMallTextTheme.sz14weight500(context),
                            decoration: InputDecoration(
                              hintText: 'Tuliskan berat produk Anda',
                              hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                              isDense: true,
                            ),
                            keyboardType: TextInputType.number,
                            controller: weightController,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Pemesanan minimum (kilogram)',
                            style: PadiMallTextTheme.sz12weight600DarkGrey(context),
                          ),
                          TextFormField(
                            style: PadiMallTextTheme.sz14weight500(context),
                            decoration: InputDecoration(
                              hintText: 'Tuliskan pemesanan minimum pada produk ini',
                              hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                              isDense: true,
                            ),
                            keyboardType: TextInputType.number,
                            controller: minOrderController,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Stok (Kg)',
                            style: PadiMallTextTheme.sz12weight600DarkGrey(context),
                          ),
                          TextFormField(
                            style: PadiMallTextTheme.sz14weight500(context),
                            decoration: InputDecoration(
                              hintText: 'Tuliskan stok yang tersedia pada produk ini',
                              hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                              isDense: true,
                            ),
                            keyboardType: TextInputType.number,
                            controller: stockController,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Stok akan berkurang otomatis jika produk terbeli. Stok dapat diperbaharui dikemudian waktu.',
                              style: PadiMallTextTheme.sz10weight500Grey(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: RaisedButton(
                        onPressed: () {
                          _providerProduct.updateProduct(context, product.id, nameController, priceController, weightController, descController, _selectedProductCategory,
                              stockController, minOrderController);
//                          Navigator.pop(context);
//                          Fluttertoast.showToast(
//                              msg: 'Data produk berhasil di edit', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
                        },
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: Text(
                          'Simpan Pengaturan',
                          style: PadiMallTextTheme.sz16weight700White(context),
                        ),
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
                itemCount: product.images.length + 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) => GestureDetector(
                  onTap: () {
//                _providerProduct.getSingleImage(context, ImageSource.gallery);
                    _providerProduct.loadAssetsPicture(index);
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: index >= product.images.length
                              ? Image.asset(
                                  'assets/images/add_picture.png',
                                  height: 75,
                                  width: 75,
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  imageUrl: imageUrlFormatter(product.images[index].url),
                                  height: 75,
                                  width: 75,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      index < product.images.length
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  _providerProduct.removeListProductImage(index);
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
