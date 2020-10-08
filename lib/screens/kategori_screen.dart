import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_product_categories.dart';
import 'package:padimall_app/models/product_main_category.dart';
import 'package:padimall_app/providers/product_categories.dart';
import 'package:padimall_app/screens/product_by_category_screen.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/not_found_widget.dart';
import 'package:provider/provider.dart';

class KategoriScreen extends StatelessWidget {
  ProviderProductCategories _productCategoriesState;

  @override
  Widget build(BuildContext context) {
    _productCategoriesState = Provider.of(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kategori',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: buildFutureBuilder(
        _productCategoriesState.getMainProductCategories(),
        Consumer<ProviderProductCategories>(
          builder: (ctx, provider, _) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    itemCount: _productCategoriesState.listMainCategories.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        child: _buildMainCategoryListTile(context, index),
                      );
                    },
                  ),
                ),
              ),
              _productCategoriesState.listMainCategories[provider.selectedMainCategoryIndex].productCategories.isEmpty
                  ? Expanded(
                      child: BuilNotFoundWidget(),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildSubCategoryCounterInformation(context),
                            ListView.builder(
                              itemCount: _productCategoriesState.listMainCategories[provider.selectedMainCategoryIndex].productCategories.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                return _buildKategoriListTile(
                                    context, _productCategoriesState.listMainCategories[provider.selectedMainCategoryIndex].productCategories[index]);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubCategoryCounterInformation(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(12, 16, 12, 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 4),
              child: Icon(
                Icons.info,
                color: Colors.black26,
                size: 15,
              ),
            ),
            Text(
              '${_productCategoriesState.listMainCategories[_productCategoriesState.selectedMainCategoryIndex].productCategories.length} sub-kategori ditemukan',
              style: PadiMallTextTheme.sz11weight500(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainCategoryListTile(BuildContext context, int indexMainCategory) {
    var _productMainCategories = _productCategoriesState.listMainCategories[indexMainCategory];

    return GestureDetector(
      onTap: () {
        _productCategoriesState.setSelectedMainCategoryIndex(indexMainCategory);
      },
      child: Container(
        color: indexMainCategory == _productCategoriesState.selectedMainCategoryIndex ? Colors.white : Colors.grey[100],
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 4),
//              foregroundDecoration: indexMainCategory == _productCategoriesState.selectedMainCategoryIndex ? null : BoxDecoration(
//                color: Colors.grey,
//                backgroundBlendMode: BlendMode.saturation
//              ),
              child: Image.network(
                '${_productMainCategories.image}',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              '${_productMainCategories.name}',
              maxLines: 4,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: PadiMallTextTheme.sz11weight500(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKategoriListTile(BuildContext context, ProductCategory productCategory) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, ProductByCategoryScreen.routeName, arguments: productCategory);
        },
        title: Text(
          '${productCategory.name}',
          style: PadiMallTextTheme.sz13weight600Soft(context),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
      ),
    );
  }
}
