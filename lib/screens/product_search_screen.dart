import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/providers/products.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/beranda/product.dart';
import 'package:padimall_app/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatefulWidget {
  static final routeName = 'product-search-screen';

  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  TextEditingController _searchInput = TextEditingController();

  bool _isLoading = false;

  ProviderProduct _providerProduct;

  @override
  Widget build(BuildContext context) {
    _providerProduct = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 15,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: TextFormField(
          decoration: InputDecoration(
            suffix: IconButton(
              onPressed: () {
                _searchInput.clear();
              },
              icon: Icon(
                Icons.clear,
                size: 15,
              ),
            ),
            hintText: 'Cari nama produk anda',
            hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          controller: _searchInput,
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (value) async {
            setState(() {
              _isLoading = true;
            });
            await _providerProduct.searchProductByName(value);
            setState(() {
              _isLoading = false;
            });
          },
        ),
      ),
      body: Consumer<ProviderProduct>(
        builder: (ctx, provider, _) => _searchInput.text == ""
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
                        'assets/images/empty_cart.svg',
                        height: 150,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Strolling . .  Strolling~',
                              style: PadiMallTextTheme.sz14weight500(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : _isLoading
                ? LoadingWidget()
                : SingleChildScrollView(
                    child: _providerProduct.listOfSearchedProduct.isEmpty
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
                                    height: 150,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Tidak ada ditemukannya barang dengan nama ',
                                          style: PadiMallTextTheme.sz14weight500(context),
                                        ),
                                        TextSpan(
                                          text: '${_searchInput.text}',
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
                                    itemCount: _providerProduct.listOfSearchedProduct.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (ctx, index) => ProductWidget(
                                      product: _providerProduct.listOfSearchedProduct[index],
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
