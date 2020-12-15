import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class EditPasswordScreen extends StatelessWidget {
  static final routeName = 'edit-password-screen';
  var _formEditPassword = GlobalKey<FormState>();
  TextEditingController _oldPassController = new TextEditingController();
  TextEditingController _newPassController = new TextEditingController();
  TextEditingController _newPassConfirmationController = new TextEditingController();
  ProviderUser _providerUser;

  @override
  Widget build(BuildContext context) {
    _providerUser = Provider.of(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ubah Password',
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: Form(
                  key: _formEditPassword,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Kata Sandi Lama',
                            hintText: 'Masukkan kata sandi anda',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: PadiMallTextTheme.sz14weight500(context),
                          obscureText: true,
                          controller: _oldPassController,
                          validator: (input) {
                            return input.isEmpty ? 'Kolom ini harus diisi' : null;
                          },
//                          onSaved: (input) => _oldPass = input,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Kata Sandi Baru',
                            hintText: 'Masukkan kata sandi baru anda',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: PadiMallTextTheme.sz14weight500(context),
                          obscureText: true,
                          controller: _newPassController,
                          validator: Validators.compose(
                            [
                              Validators.required('Kolom ini hendak diisi'),
                              Validators.patternRegExp(
                                  RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{0,}$'),
                                  'Pastikan diisi dengan 1 huruf besar, 1 huruf kecil, dan 1 angka'),
                              Validators.minLength(
                                  8, 'Diisi dengan minimal 8 karakter'),
                            ],
                          ),
//                          onSaved: (input) => _newPass = input,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Konfirmasi Kata Sandi Baru',
                            hintText: 'Masukkan kembali kata sandi baru anda',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: PadiMallTextTheme.sz14weight500(context),
                          controller: _newPassConfirmationController,
                          obscureText: true,
                          validator: (input) {
                            return input.isEmpty ? 'Kolom ini harus diisi' : null;
                          },
//                          onSaved: (input) => _newPassConfirmation = input,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[100],
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 0),
                )
              ],
            ),
            child: Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  if (_formEditPassword.currentState.validate()) {
                    _formEditPassword.currentState.save();
                    if (_newPassController.text == _newPassConfirmationController.text) {
                      _providerUser.changePasswordUser(context, _oldPassController, _newPassController);
                    } else {
                      _oldPassController.clear();
                      _newPassController.clear();
                      _newPassConfirmationController.clear();
                      Fluttertoast.showToast(msg: 'Kata sandi tidak sama dengan kolom konfirmasi kata sandi', backgroundColor: Theme.of(context).accentColor, toastLength: Toast.LENGTH_LONG);
                    }
                  }
                },
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                child: Text(
                  'Ubah Password',
                  style: PadiMallTextTheme.sz14weight700White(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
