import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/screens/first_screen.dart';
import 'package:padimall_app/screens/forgot_pass_sent_screen.dart';
import 'package:padimall_app/screens/register_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static final routeName = 'forgot-password-screen';
  String _email;
  var _formForgotPassword = GlobalKey<FormState>();
  ProviderUser _providerUser;

  @override
  Widget build(BuildContext context) {
    _providerUser = Provider.of<ProviderUser>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formForgotPassword,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Image.asset(
                      'assets/images/password.png',
                      height: 125,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Lupa Password Anda?',
                      style: PadiMallTextTheme.sz16weight700(context),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 36, left: 8, right: 8),
                    child: Text(
                      'Masukkan email terdaftar anda, kami akan mengirimkan hak akses untuk mengubah password anda',
                      textAlign: TextAlign.center,
                      style: PadiMallTextTheme.sz12weight500Grey(context),
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
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: RaisedButton(
                      onPressed: () {
                        if (_formForgotPassword.currentState.validate()) {
                          _formForgotPassword.currentState.save();
                          _providerUser.forgotPassword(context, _email);
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Kirim',
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
