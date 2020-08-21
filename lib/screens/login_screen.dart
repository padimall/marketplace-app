import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = 'login-screen';
  bool isPassVisible = false;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;

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
                      labelText: 'Email',
                      hintText: 'Masukkan email anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (input) {
                      return input.isEmpty ? 'Kolom ini harus diisi' : null;
                    },
                    onSaved: (input) => _email = input,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Kata Sandi',
                      hintText: 'Masukkan kata sandi anda',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(widget.isPassVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: Colors.grey,
                        onPressed: () {
                          widget.isPassVisible = !widget.isPassVisible;
                          setState(() {});
                        },
                      ),
                    ),
                    obscureText: widget.isPassVisible ? false : true,
                    validator: (input) {
                      return input.isEmpty ? 'Kolom ini harus diisi' : null;
                    },
                    onSaved: (input) => _password = input,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Lupa kata sandi',
                        style: PadiMallTextTheme.sz13weigth500Green(context),
                      ),
                    ],
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
                      'Masuk',
                      style: PadiMallTextTheme.sz16weigth700White(context),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: PadiMallTextTheme.sz14weigth500Grey(context)
                              .copyWith(height: 1.5),
                          children: [
                            TextSpan(text: 'Belum punya akun? '),
                            TextSpan(
                              text: 'Daftar disini',
                              style:
                                  PadiMallTextTheme.sz14weigth700Green(context)
                                      .copyWith(
                                          decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ],
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
