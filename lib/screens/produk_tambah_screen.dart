import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class ProdukTambahScreen extends StatelessWidget {
  static final routeName = 'produk-tambah-screen';

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              _buildProductPicture(context),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Nama Produk',
                      style: PadiMallTextTheme.sz12weight600(context),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Tuliskan nama produk Anda',
                        hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                      ),
                      maxLength: 50,
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
                      'Kategori Produk',
                      style: PadiMallTextTheme.sz12weight600(context),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Pilih kategori produk Anda',
                        hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                      ),
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
                      style: PadiMallTextTheme.sz12weight600(context),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Tuliskan harga produk Anda',
                        hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                      ),
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
                      style: PadiMallTextTheme.sz12weight600(context),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Tuliskan berat produk Anda',
                        hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                      ),
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
                      style: PadiMallTextTheme.sz12weight600(context),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Tuliskan pemesanan minimum pada produk ini',
                        hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Nama Produk',
                      style: PadiMallTextTheme.sz12weight600(context),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Tuliskan nama produk Anda',
                        hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                      ),
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
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: RaisedButton(
                  onPressed: () {},
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
    );
  }

  Widget _buildProductPicture(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Gambar Produk',
            style: PadiMallTextTheme.sz12weight600(context),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/bawang.jpg',
                height: 75,
                width: 75,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
