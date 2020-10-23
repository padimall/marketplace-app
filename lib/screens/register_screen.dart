import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class RegisterScreen extends StatefulWidget {
  static final routeName = 'register-screen';
  var _formRegister = GlobalKey<FormState>();

  bool _isPassVisible = false;
  bool _isPassConfirmedVisible = false;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ProviderUser _providerUser;

  String _name, _phoneNum, _address, _email, _pass, _passConfirmed;

  @override
  Widget build(BuildContext context) {
    _providerUser = Provider.of<ProviderUser>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: widget._formRegister,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 125,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
                        hintText: 'Masukkan nama lengkap anda',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: PadiMallTextTheme.sz14weight500(context),
                      validator: (input) {
                        return input.isEmpty ? 'Kolom ini hendak diisi' : null;
                      },
                      onSaved: (input) => _name = input,
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
                    margin: const EdgeInsets.only(bottom: 24),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Alamat Lengkap',
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
                        labelText: 'Email',
                        hintText: 'Masukkan email anda',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      style: PadiMallTextTheme.sz14weight500(context),
                      validator: Validators.compose([
                        Validators.required('Kolom ini hendak diisi'),
                        Validators.patternRegExp(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'), 'Format Email salah')
                      ]),
                      onSaved: (input) => _email = input,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Kata Sandi',
                        hintText: 'Masukkan kata sandi anda',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(widget._isPassVisible ? Icons.visibility : Icons.visibility_off),
                          color: Colors.grey,
                          onPressed: () {
                            widget._isPassVisible = !widget._isPassVisible;
                            setState(() {});
                          },
                        ),
                      ),
                      style: PadiMallTextTheme.sz14weight500(context),
                      obscureText: widget._isPassVisible ? false : true,
                      validator: Validators.compose(
                        [
                          Validators.required('Kolom ini hendak diisi'),
                          Validators.patternRegExp(
                              RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{0,}$'), 'Pastikan diisi dengan 1 huruf besar, 1 huruf kecil, dan 1 angka'),
                          Validators.minLength(8, 'Diisi dengan minimal 8 karakter'),
                        ],
                      ),
                      onSaved: (input) => _pass = input,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Konfirmasi Kata Sandi',
                        hintText: 'Konfirmasi kata sandi anda',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(widget._isPassConfirmedVisible ? Icons.visibility : Icons.visibility_off),
                          color: Colors.grey,
                          onPressed: () {
                            widget._isPassConfirmedVisible = !widget._isPassConfirmedVisible;
                            setState(() {});
                          },
                        ),
                      ),
                      style: PadiMallTextTheme.sz14weight500(context),
                      obscureText: widget._isPassConfirmedVisible ? false : true,
                      validator: (input) {
                        return input.isEmpty ? 'Kolom ini hendak diisi' : null;
                      },
                      onSaved: (input) => _passConfirmed = input,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: RaisedButton(
                      onPressed: () {
                        if (widget._formRegister.currentState.validate()) {
                          widget._formRegister.currentState.save();
                          if (_pass == _passConfirmed) {
                            _providerUser.signUpUser(context, _name, _address, _email, _phoneNum, _pass, _passConfirmed);
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Kata sandi tidak sama dengan kolom konfirmasi kata sandi', backgroundColor: Colors.grey, toastLength: Toast.LENGTH_LONG);
                          }
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: Text(
                        'Buat akun',
                        style: PadiMallTextTheme.sz16weight700White(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
