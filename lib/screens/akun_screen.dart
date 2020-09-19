import 'package:flutter/material.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/akun/akun_pembeli.dart';
import 'package:padimall_app/widgets/akun/no_toko_yet.dart';
import 'package:padimall_app/widgets/akun/no_user_yet.dart';
import 'package:padimall_app/widgets/akun/toko_saya.dart';
import 'package:provider/provider.dart';

class AkunScreen extends StatelessWidget {
  ProviderToko _providerToko;
  ProviderUser _providerUser;

  @override
  Widget build(BuildContext context) {
    _providerToko = Provider.of(context, listen: false);
    _providerUser = Provider.of(context, listen: false);

    return DefaultTabController(
      length: akunTabChoices.length,
      child: buildFutureBuilder(
        _providerUser.checkIsUserLogin(),
        Consumer<ProviderUser>(
          builder: (ctx, provider, _) => Scaffold(
            appBar: AppBar(
              title: Text(
                'Akun',
                style: PadiMallTextTheme.sz16weight700(context),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              bottom: _providerUser.isUserLogin
                  ? TabBar(
                      labelStyle: PadiMallTextTheme.sz16weight700(context),
                      tabs: akunTabChoices
                          .map<Widget>((AkunTabChoice akunTabChoice) => Tab(
                                text: akunTabChoice.choiceTitle,
                              ))
                          .toList())
                  : null,
            ),
            body: _providerUser.isUserLogin
                ? Consumer<ProviderToko>(
                    builder: (ctx, provider, _) => TabBarView(
                      children: <Widget>[
                        AkunPembeliWidget(),
                        _providerToko.isAlreadyHaveToko ? TokoSayaWidget() : NoTokoYetWidget(),
                      ],
                    ),
                  )
                : NoUserYetWidget(),
            backgroundColor: Colors.white,
          ),
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
