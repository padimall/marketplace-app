import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';

class AkunListTile extends StatelessWidget {
  String title;
  String subtitle;
  Function handler;

  AkunListTile({this.title, this.subtitle, this.handler});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(title, style: PadiMallTextTheme.sz14weight600(context),),
        subtitle: subtitle.isEmpty ? null : Text(subtitle, style: PadiMallTextTheme.sz12weight500Grey(context),),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: handler,
      ),
    );
  }
}