import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class KategoriScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            return _buildKategoriListTile(context, 'Kategori');
          },
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
