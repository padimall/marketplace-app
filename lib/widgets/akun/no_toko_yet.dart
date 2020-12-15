import 'package:flutter/material.dart';
import 'package:padimall_app/screens/regis_agent_screen.dart';
import 'package:padimall_app/screens/regis_supplier_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class NoTokoYetWidget extends StatelessWidget {
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
              'Ayo, mari bergabung dengan PadiMall',
              style: PadiMallTextTheme.sz13weight600Soft(context),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, RegisterSupplierScreen.routeName);
              },
              child: Text(
                'Jadi Supplier',
                style: PadiMallTextTheme.sz14weight700White(context),
              ),
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, RegisterAgentScreen.routeName);
            },
            child: Text(
              'Jadi Agen',
              style: PadiMallTextTheme.sz14weight700(context),
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
