import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class InfoBuyerScreen extends StatelessWidget {
  static final routeName = 'info-buyer-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informasi Akun',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 15,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildInfoRow(context, 'Nama', 'Ricky Julpiter'),
              _buildInfoRow(context, 'No. Handphone', '+62 123-4567-890'),
              _buildInfoRow(context, 'Email', 'ricky@padimall.com'),
              _buildInfoRow(context, 'Alamat Lengkap',
                  'Jl. Pinang Baris, No.1. Kota Medan, Sumatera Utara '),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '$label',
                    style: PadiMallTextTheme.sz11weight500(context),
                  ),
                ),
                Text(
                  '$value',
                  style: PadiMallTextTheme.sz12weight600Soft(context),
                ),
              ],
            ),
          ),
          Icon(
            Icons.edit,
            size: 20,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
