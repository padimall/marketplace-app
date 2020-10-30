import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:padimall_app/models/post_show_product_categories.dart';
import 'package:padimall_app/providers/product_categories.dart';
import 'package:padimall_app/providers/products.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:provider/provider.dart';

class ProdukTambahScreen extends StatelessWidget {
  static final routeName = 'produk-tambah-screen';
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = MoneyMaskedTextController(thousandSeparator: '.', precision: 0, decimalSeparator: '');
  final weightController = MoneyMaskedTextController(thousandSeparator: '.', precision: 0, decimalSeparator: '');
  final minOrderController = MoneyMaskedTextController(thousandSeparator: '.', precision: 0, decimalSeparator: '');
  final stockController = MoneyMaskedTextController(thousandSeparator: '.', precision: 0, decimalSeparator: '');
  String _productCategoryId;

  int _maxPicture = 8;

  var _formAddProduct = GlobalKey<FormState>();

  ProviderProductCategories _providerProductCategories;
  ProviderProduct _providerProduct;

  @override
  Widget build(BuildContext context) {
    _providerProductCategories = Provider.of<ProviderProductCategories>(context, listen: false);
    _providerProduct = Provider.of<ProviderProduct>(context, listen: false);

    _providerProduct.resetListProductImage();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Produk',
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
          builder: (ctx, provider, _) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formAddProduct,
                child: Column(
                  children: <Widget>[
                    _buildProductPicture(context),
                    Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Nama',
                            style: PadiMallTextTheme.sz12weight600DarkGrey(context),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Tuliskan nama produk Anda',
                              hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                            ),
                            maxLength: 50,
                            controller: nameController,
                            validator: (input) {
                              return input.isEmpty ? 'Kolom ini harus diisi' : null;
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
                          DropdownSearch(
                            mode: Mode.BOTTOM_SHEET,
                            isFilteredOnline: true,
//                          showClearButton: true,
                            showSearchBox: true,
                            label: 'Kategori Produk',
//                          clearButton: Icon(Icons.clear),
                            autoFocusSearchBox: true,
                            dropdownSearchDecoration: InputDecoration(
                              hintText: 'Tentukan kategori produk Anda',
                              hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                              labelStyle: PadiMallTextTheme.sz12weight600DarkGrey(context),
                              contentPadding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            items: _providerProductCategories.listProductCategories,
                            itemAsString: (ProductCategory item) => item.name,
                            onChanged: (ProductCategory productCategory) {
                              _productCategoryId = productCategory.id;
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
                            'Harga',
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
                                  decoration: InputDecoration(
                                    hintText: 'Tuliskan harga produk Anda',
                                    hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                                  ),
                                  controller: priceController,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
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
                            decoration: InputDecoration(
                              hintText: 'Tuliskan berat produk Anda',
                              hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                            ),
                            controller: weightController,
                            keyboardType: TextInputType.number,
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
                            decoration: InputDecoration(
                              hintText: 'Tuliskan pemesanan minimum pada produk ini',
                              hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                            ),
                            controller: minOrderController,
                            keyboardType: TextInputType.number,
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
                            decoration: InputDecoration(
                              hintText: 'Tuliskan stok yang tersedia pada produk ini',
                              hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                            ),
                            controller: stockController,
                            keyboardType: TextInputType.number,
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
                          if (_formAddProduct.currentState.validate()) {
                            _formAddProduct.currentState.save();
                            _providerProduct.addProduct(context, nameController, priceController, weightController, descController, _productCategoryId,
                                stockController, minOrderController);
//                            Navigator.pop(context);
//                            Fluttertoast.showToast(
//                                msg: 'Produk berhasil di ditambahkan', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
                          }
                        },
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: Text(
                          'Tambahkan Produk',
                          style: PadiMallTextTheme.sz16weight700White(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductPicture(BuildContext context) {
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
                itemCount: _providerProduct.listProductImage.length + 1,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) => Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: index >= _providerProduct.listProductImage.length
                            ? GestureDetector(
                                onTap: () {
                                  _providerProduct.loadAssetsPicture(index);
                                },
                                child: Image.asset(
                                  'assets/images/add_picture.png',
                                  height: 75,
                                  width: 75,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.file(
                                _providerProduct.listProductImage[index],
                                height: 75,
                                width: 75,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    index < _providerProduct.listProductImage.length
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
          ],
        ),
      ),
    );
  }
}
