import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class RegisterScreen extends StatefulWidget {
  static final routeName = 'register-screen';
  String _name, _phoneNum, _email, _pass, _passConfirmed;
  bool _isPassVisible = false;
  bool _isPassConfirmedVisible = false;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: Image.asset('assets/images/logo.png'),
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
                    validator: (input) {
                      return input.isEmpty ? 'Kolom ini harus diisi' : null;
                    },
                    onSaved: (input) => widget._name = input,
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
                    validator: (input) {
                      return input.isEmpty ? 'Kolom ini harus diisi' : null;
                    },
                    onSaved: (input) => widget._phoneNum = input,
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
                    validator: (input) {
                      return input.isEmpty ? 'Kolom ini harus diisi' : null;
                    },
                    onSaved: (input) => widget._email = input,
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
                        icon: Icon(widget._isPassVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: Colors.grey,
                        onPressed: () {
                          widget._isPassVisible = !widget._isPassVisible;
                          setState(() {});
                        },
                      ),
                    ),
                    obscureText: widget._isPassVisible ? false : true,
                    validator: (input) {
                      return input.isEmpty ? 'Kolom ini harus diisi' : null;
                    },
                    onSaved: (input) => widget._pass = input,
                  ),
                ),Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Konfirmasi Kata Sandi',
                      hintText: 'Konfirmasi kata sandi anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(widget._isPassConfirmedVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: Colors.grey,
                        onPressed: () {
                          widget._isPassConfirmedVisible = !widget._isPassConfirmedVisible;
                          setState(() {});
                        },
                      ),
                    ),
                    obscureText: widget._isPassConfirmedVisible ? false : true,
                    validator: (input) {
                      return input.isEmpty ? 'Kolom ini harus diisi' : null;
                    },
                    onSaved: (input) => widget._pass = input,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: RaisedButton(
                    onPressed: () {},
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
    );
  }
}
