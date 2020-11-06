import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/info_agent/edit_dialog.dart';
import 'package:padimall_app/widgets/info_toko/edit_dialog.dart';
import 'package:provider/provider.dart';

class InfoAgentEditScreen extends StatefulWidget {
  static final routeName = 'info-toko-edit-screen';

  @override
  _InfoAgentEditScreenState createState() => _InfoAgentEditScreenState();
}

class _InfoAgentEditScreenState extends State<InfoAgentEditScreen> {
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
        _providerToko.updateSupplierImage(context, _imageSelected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _providerToko = Provider.of<ProviderToko>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ubah Informasi Agen',
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
      body: Consumer<ProviderToko>(
        builder: (ctx, provider, _) => Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
//                _buildAgentPicture(context),
                _buildInfoRow(context, 'Nama Toko', '${_providerToko.agentDetail.name}', 0),
                _buildInfoRow(context, 'Alamat', '${_providerToko.agentDetail.address}', 1),
                _buildInfoRow(context, 'No. HP', '${_providerToko.agentDetail.phone}', 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, int indexProfile) {
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
                  style: PadiMallTextTheme.sz13weight600Soft(context),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => EditAgentDialogWidget.show(context, label, value, indexProfile),
            child: Icon(
              Icons.edit,
              size: 20,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }

//  Widget _buildAgentPicture(BuildContext context) {
//    return Consumer<ProviderToko>(
//      builder: (ctx, provider, _) => Container(
//        margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Container(
//              margin: const EdgeInsets.only(bottom: 0),
//              child: Text(
//                'Gambar Agent',
//                style: PadiMallTextTheme.sz12weight600(context),
//              ),
//            ),
//            Container(
//              alignment: Alignment.center,
//              width: double.infinity,
//              margin: const EdgeInsets.all(8.0),
//              child: ClipRRect(
//                borderRadius: BorderRadius.circular(6),
//                child: _providerToko.agentDetail.imageUrl != null
//                    ? GestureDetector(
//                    onTap: () {
//                      CustomAlertDialog.editAndDeletePicture(
//                        context,
//                            () {
//                          Navigator.pop(context);
//                          getImage(context, ImageSource.gallery);
//                        },
//                            () {
//                          Navigator.pop(context);
//                          // TODO: DELETE PIC
//                          _providerToko.deleteSupplierImage(context);
//                        },
//                      );
//                    },
//                    child: Stack(
//                      alignment: Alignment.center,
//                      children: [
//                        CachedNetworkImage(
//                          imageUrl: (_providerToko.agentDetail.imageUrl),
//                          height: 75,
//                          width: 75,
//                          fit: BoxFit.cover,
//                        ),
//                        Positioned(
//                          bottom: 0,
//                          child: Container(
//                            height: 20,
//                            width: 75,
//                            color: Colors.black87.withOpacity(0.4),
//                            child: Text(
//                              'Edit',
//                              textAlign: TextAlign.center,
//                              style: PadiMallTextTheme.sz11weight700White(context),
//                            ),
//                          ),
//                        )
//                      ],
//                    ))
//                    : _imageSelected == null
//                    ? GestureDetector(
//                  onTap: () {
//                    getImage(context, ImageSource.gallery);
//                  },
//                  child: Image.asset(
//                    'assets/images/add_picture.png',
//                    height: 75,
//                    width: 75,
//                    fit: BoxFit.cover,
//                  ),
//                )
//                    : Image.file(
//                  _imageSelected,
//                  height: 75,
//                  width: 75,
//                  fit: BoxFit.cover,
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
}
