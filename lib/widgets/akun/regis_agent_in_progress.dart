import 'package:flutter/material.dart';
import 'package:padimall_app/screens/regis_agent_screen.dart';
import 'package:padimall_app/screens/regis_supplier_screen.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class RegisAgentInProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/business.png',
              height: 200,
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 20),
              child: Text(
                'Registrasi Agen anda sedang diproses,\n mohon menunggu',
                textAlign: TextAlign.center,
                style: PadiMallTextTheme.sz13weight600Soft(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
