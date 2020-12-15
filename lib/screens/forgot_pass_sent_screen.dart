import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/screens/first_screen.dart';
import 'package:padimall_app/screens/register_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class ForgotPassSentScreen extends StatelessWidget {
  static final routeName = 'forgot-pass-sent-screen';

  @override
  Widget build(BuildContext context) {
    final String _emailSent = ModalRoute.of(context).settings.arguments;

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: SvgPicture.asset(
                    'assets/images/email.svg',
                    height: 125,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Cek email Anda',
                    style: PadiMallTextTheme.sz16weight700(context),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 36, left: 8, right: 8),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: PadiMallTextTheme.sz12weight500Grey(context).copyWith(height: 1.5),
                      children: [
                        TextSpan(text: 'Kami telah mengirimkan hak akses untuk mengubah password anda pada '),
                        TextSpan(
                          text: '$_emailSent',
                          style: PadiMallTextTheme.sz12weight600(context),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Masuk Kembali',
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
