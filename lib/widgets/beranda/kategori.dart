import 'package:flutter/material.dart';
import 'package:padimall_app/providers/product_categories.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:provider/provider.dart';

class BerandaKategori extends StatelessWidget {
  ProviderProductCategories _productCategoriesState;

  @override
  Widget build(BuildContext context) {
    _productCategoriesState = Provider.of(context, listen: false);

    int _tempItemCount = 5;
    return buildFutureBuilder(
      _productCategoriesState.getProductCategories(),
      Consumer<ProviderProductCategories>(
        builder: (ctx, provider, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Kategori',
                textAlign: TextAlign.left,
                style: PadiMallTextTheme.sz16weight700(context),
              ),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  double _leftMargin = 4.0;
                  double _rightMargin = 4.0;

                  if (index == 0) {
                    _leftMargin = 16;
                  }
                  if (index == _tempItemCount - 1) {
                    _rightMargin = 16;
                  }

                  return Container(
                    margin: EdgeInsets.only(left: _leftMargin, right: _rightMargin),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.black,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment(1.0, 1.0),
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Opacity(
                              opacity: 0.6,
                              child: Container(
                                child: Image.asset(
                                  'assets/images/bawang.jpg',
                                  width: 125,
                                  height: 125,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                '${_productCategoriesState.listProductCategories[index].name}',
                                textAlign: TextAlign.center,
                                style: PadiMallTextTheme.sz14weight700White(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: _productCategoriesState.listProductCategories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
