import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class InvoiceActionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(0,0)
            )
          ]
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: RaisedButton(
        onPressed: () {},
        child: Text(
          'Berikan Ulasan',
          style: PadiMallTextTheme.sz16weight700White(context),
        ),
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
      ),
    );
  }
}
