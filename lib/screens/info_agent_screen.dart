import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:padimall_app/models/post_show_supplier_detail.dart';
import 'package:padimall_app/models/post_show_suppliers_agent_detail.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/screens/info_agent_edit_screen.dart';
import 'package:padimall_app/screens/info_toko_edit_screen.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:provider/provider.dart';

class InfoAgentScreen extends StatefulWidget {
  static final routeName = 'info-agent-screen';

  @override
  _InfoAgentScreenState createState() => _InfoAgentScreenState();
}

class _InfoAgentScreenState extends State<InfoAgentScreen> {
  ProviderToko _providerToko;

  File _imageSelected;

  getImage(BuildContext context, ImageSource imageSource) async {
    var image = await ImagePicker.pickImage(source: imageSource);

    if (image != null) {
      var cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
        compressQuality: 30,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.png,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Theme.of(context).primaryColor,
          toolbarTitle: "Crop your image",
        ),
      );

      setState(() {
        _imageSelected = cropped;
        print('image: ${_imageSelected.path}');
        _providerToko.updateImage(context, _imageSelected, "agent");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _providerToko = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informasi Agen',
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
            _buildAgentInfo(context),
            _buildListOfSuppliers(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAgentInfo(BuildContext context) {
    return Consumer<ProviderToko>(
      builder: (ctx, provider, _) {
        Agent _agentDetail = _providerToko.agentDetail;

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
                      'Agen',
                      style: PadiMallTextTheme.sz14weight600Soft(context),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('bah');
                      Navigator.pushNamed(context, InfoAgentEditScreen.routeName);
                    },
                    child: Text(
                      'Ubah',
                      style: PadiMallTextTheme.sz12weight600Green(context),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: _agentDetail.imageUrl == null
                          ? Image.asset(
                              'assets/images/no_image.png',
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            )
                          : FadeInImage.assetNetwork(
                              image: '${_agentDetail.imageUrl}',
                              fit: BoxFit.cover,
                              placeholder: 'assets/images/logo.png',
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
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            '${_agentDetail.name}',
                            style: PadiMallTextTheme.sz14weight600Soft(context),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Row(
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
                                '${_agentDetail.phone}',
                                style: PadiMallTextTheme.sz12weight500Grey(context),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(right: 4),
                                  child: Icon(
                                    Icons.vpn_key,
                                    color: Colors.grey,
                                    size: 15,
                                  ),
                                ),
                                Text(
                                  '${_agentDetail.agentCode}',
                                  style: PadiMallTextTheme.sz12weight500Grey(context),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                FlutterClipboard.copy(_agentDetail.agentCode).then((value) => Fluttertoast.showToast(
                                    msg: 'Kode Agen berhasil di copy',
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: Theme.of(context).primaryColor));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 8),
                                child: Icon(
                                  Icons.content_copy,
                                  color: Colors.grey[600],
                                  size: 20,
                                ),
                              ),
                            )
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
      },
    );
  }

  Widget _buildListOfSuppliers(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            'Supplier Saya',
            style: PadiMallTextTheme.sz14weight600Soft(context),
          ),
        ),
        _providerToko.agentDetail.suppliers.length < 1
            ? Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Anda belum memiliki Supplier',
                  style: PadiMallTextTheme.sz12weight500Grey(context),
                ),
              )
            : ListView.builder(
                itemCount: _providerToko.agentDetail.suppliers.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var supplier = _providerToko.agentDetail.suppliers[index];

                  print("is : ${supplier.imageUrl == null}");
                  return Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 12),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: supplier.imageUrl == null
                                    ? Image.asset(
                                        'assets/images/no_image.png',
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      )
                                    : FadeInImage.assetNetwork(
                                        image: '${supplier.imageUrl}',
                                        fit: BoxFit.cover,
                                        placeholder: 'assets/images/logo.png',
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
                                      '${supplier.name}',
                                      style: PadiMallTextTheme.sz14weight600Soft(context),
                                    ),
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
                                        '${supplier.phone}',
                                        style: PadiMallTextTheme.sz12weight500Grey(context),
                                      ),
                                    ],
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
                                        '${supplier.address}',
                                        style: PadiMallTextTheme.sz12weight500Grey(context),
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
                },
              ),
      ],
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
