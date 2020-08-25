import 'package:flutter/material.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/akun/akun_pembeli.dart';

class AkunScreen extends StatelessWidget {
//  final AkunTabChoice akunTabChoices;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: akunTabChoices.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Akun',
            style: PadiMallTextTheme.sz16weight700(context),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: TabBar(
              labelStyle: PadiMallTextTheme.sz16weight700(context),
              tabs: akunTabChoices
                  .map<Widget>((AkunTabChoice akunTabChoice) => Tab(
                        text: akunTabChoice.choiceTitle,
                      ))
                  .toList()),
        ),
        body: TabBarView(
          children: <Widget>[
            AkunPembeliWidget(),
            Text('Dua'),
          ],
        ),
      ),
    );
  }
}

class AkunTabChoice {
  final String choiceTitle;

  const AkunTabChoice({this.choiceTitle});
}

const List<AkunTabChoice> akunTabChoices = <AkunTabChoice>[
  AkunTabChoice(choiceTitle: 'Akun Pembeli'),
  AkunTabChoice(choiceTitle: 'Toko Saya'),
];
