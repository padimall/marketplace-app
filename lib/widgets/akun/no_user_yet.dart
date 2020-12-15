import 'package:flutter/material.dart';
import 'package:padimall_app/screens/login_screen.dart';
import 'package:padimall_app/screens/regis_supplier_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class NoUserYetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/business.png',
            height: 200,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Ayo masuk dulu, jangan ragu',
              style: PadiMallTextTheme.sz13weight600Soft(context),
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
            child: Text(
              'Sign In',
              style: PadiMallTextTheme.sz14weight700White(context),
            ),
            color: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          )
        ],
      ),
    );
  }
}
