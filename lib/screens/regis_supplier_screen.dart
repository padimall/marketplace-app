import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class RegisterSupplierScreen extends StatefulWidget {
  static final routeName = 'regis-supplier-screen';

  @override
  _RegisterSupplierScreenState createState() => _RegisterSupplierScreenState();
}

class _RegisterSupplierScreenState extends State<RegisterSupplierScreen> {
  var _formRegister = GlobalKey<FormState>();

  TextEditingController _agentCodeController = TextEditingController();

  String _storeName, _address, _NIB, _phoneNum;

  ProviderToko _providerToko;

  File _imageSelected;

  _getImage(BuildContext context, ImageSource imageSource) async {
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _providerToko = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registrasi Supplier',
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
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formRegister,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildSupplierPicture(context),
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      hintText: 'Masukkan nama anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxLength: 30,
                    style: PadiMallTextTheme.sz14weight500(context),
                    validator: (input) {
                      return input.isEmpty ? 'Kolom ini hendak diisi' : null;
                    },
                    onSaved: (input) => _storeName = input,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Alamat',
                      hintText: 'Masukkan alamat lengkap anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: PadiMallTextTheme.sz14weight500(context),
                    validator: (input) {
                      return input.isEmpty ? 'Kolom ini hendak diisi' : null;
                    },
                    onSaved: (input) => _address = input,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'No. Handphone',
                      hintText: 'Masukkan nomor HP anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: PadiMallTextTheme.sz14weight500(context),
                    keyboardType: TextInputType.number,
                    validator: Validators.compose(
                        [Validators.required('Kolom ini hendak diisi'), Validators.minLength(10, 'Nomor yang dimasukkan minimal memiliki 10 digit angka')]),
                    onSaved: (input) => _phoneNum = input,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'NIB',
                          hintText: 'Cth: 1234567890',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: PadiMallTextTheme.sz14weight500(context),
                        validator: (input) {
                          return input.isEmpty ? 'Kolom ini hendak diisi' : null;
                        },
                        onSaved: (input) => _NIB = input,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4, top: 4),
                        child: Text(
                          'NIB merupakan data yang diberikan oleh Administrator',
                          style: PadiMallTextTheme.sz11weight500Grey(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Kode Agen',
                          hintText: 'Cth: AGEN-002',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: PadiMallTextTheme.sz14weight500(context),
                        controller: _agentCodeController,
                        validator: (input) {
                          return input.isEmpty ? 'Kolom ini hendak diisi' : null;
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4, top: 4),
                        child: Text(
                          'Kode agen merupakan data yang diberikan oleh Agen anda',
                          style: PadiMallTextTheme.sz11weight500Grey(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formRegister.currentState.validate()) {
                        _formRegister.currentState.save();
                        _providerToko.createSupplier(context, _storeName, _address, _phoneNum, _NIB, _agentCodeController, _imageSelected);
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Jadi Supplier',
                      style: PadiMallTextTheme.sz16weight700White(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSupplierPicture(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Gambar Toko',
            style: PadiMallTextTheme.sz12weight600(context),
          ),
          GestureDetector(
            onTap: () {
              if (_imageSelected == null) {
                _getImage(context, ImageSource.gallery);
              } else {
                CustomAlertDialog.editAndDeletePicture(
                  context,
                  () {
                    Navigator.pop(context);
                    _getImage(context, ImageSource.gallery);
                  },
                  () {
                    Navigator.pop(context);
                    setState(() {
                      _imageSelected = null;
                    });
                  },
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: _imageSelected == null
                    ? Image.asset(
                        'assets/images/add_picture.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        _imageSelected,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
