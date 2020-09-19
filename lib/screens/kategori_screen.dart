import 'package:flutter/material.dart';
import 'package:padimall_app/providers/product_categories.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
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
      body: buildFutureBuilder(
        _productCategoriesState.getProductCategories(),
        SingleChildScrollView(
          child: ListView.builder(
            itemCount: _productCategoriesState.listProductCategories.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, index) {
              return _buildKategoriListTile(context, '${_productCategoriesState.listProductCategories[index].name}');
            },
          ),
        ),
      ),
    );
  }

  Widget _buildKategoriListTile(BuildContext context, String title) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () {},
        title: Text(
          '$title',
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
