import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class InfoTokoScreen extends StatelessWidget {
  static final routeName = 'info-toko-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informasi Toko',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
        elevation: 0,
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
        child: Column(
          children: <Widget>[
            _buildTokoInfo(context),
            _buildAgenInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTokoInfo(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Toko',
                  style: PadiMallTextTheme.sz14weight600Soft(context),
                ),
              ),
              Icon(Icons.edit, size: 20, color: Theme.of(context).accentColor,)
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl:
                    'https://cdn.pixabay.com/photo/2014/01/19/12/31/onions-248027_1280.jpg',
                    fit: BoxFit.cover,
                    placeholder: (ctx, url) => Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    height: 60,
                    width: 60,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        'Toko Subur Selalu',
                        style: PadiMallTextTheme.sz14weight600Soft(context),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ),
                        Text(
                          'Medan, Sumatera Utara',
                          style:
                          PadiMallTextTheme.sz12weight500Grey(context),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          child: Icon(
                            Icons.call,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ),
                        Text(
                          '+62 812-3456-7890',
                          style:
                          PadiMallTextTheme.sz12weight500Grey(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAgenInfo(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Agen',
              style: PadiMallTextTheme.sz14weight600Soft(context),
            ),
          ),
          _buildInfoRow(context, 'No. Agen', 'AGEN-001'),
          _buildInfoRow(context, 'Nama Agen', 'Agen Sejahtera Selalu'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
    );
  }
}
