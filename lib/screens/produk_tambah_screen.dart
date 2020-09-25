import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class ProdukTambahScreen extends StatelessWidget {
  static final routeName = 'produk-tambah-screen';
  final nameController = TextEditingController();
  final priceController = MoneyMaskedTextController(
      thousandSeparator: '.', precision: 0, decimalSeparator: '');
  final weightController = MoneyMaskedTextController(
      thousandSeparator: '.', precision: 0, decimalSeparator: '');
  final minOrderController = MoneyMaskedTextController(
      thousandSeparator: '.', precision: 0, decimalSeparator: '');
  final stockController = MoneyMaskedTextController(
      thousandSeparator: '.', precision: 0, decimalSeparator: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
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
                      controller: nameController,
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
                      style: PadiMallTextTheme.sz12weight600(context),
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
                      style: PadiMallTextTheme.sz12weight600(context),
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
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: 'Produk berhasil di ditambahkan',
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Theme.of(context).primaryColor);
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
                'assets/images/add_picture.png',
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
