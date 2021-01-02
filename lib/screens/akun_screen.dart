import 'package:flutter/material.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/akun/agent_saya.dart';
import 'package:padimall_app/widgets/akun/akun_pembeli.dart';
import 'package:padimall_app/widgets/akun/no_toko_yet.dart';
import 'package:padimall_app/widgets/akun/no_user_yet.dart';
import 'package:padimall_app/widgets/akun/regis_agent_in_progress.dart';
import 'package:padimall_app/widgets/akun/toko_saya.dart';
import 'package:provider/provider.dart';

class AkunScreen extends StatefulWidget {
  @override
  _AkunScreenState createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  ProviderToko _providerToko;

  ProviderUser _providerUser;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () {
      _providerToko.getAgentDetail(context);
      _providerToko.getSupplierDetail(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    _providerToko = Provider.of<ProviderToko>(context, listen: false);
    _providerUser = Provider.of<ProviderUser>(context, listen: false);

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
                        _returnTokoSayaWidget(),
//                          _providerToko.agentDetail != null ? AgentSayaWidget() : (_providerToko.supplierDetail != null
//                              ? TokoSayaWidget()
//                              : NoTokoYetWidget()),
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

  Widget _returnTokoSayaWidget() {
    if (_providerToko.agentDetail != null) {
      if (_providerToko.agentDetail.status == 0) {
        return RegisAgentInProgress();
      } else if (_providerToko.agentDetail.status == 1) {
        return AgentSayaWidget();
      }
    } else if (_providerToko.supplierDetail != null) {
      return TokoSayaWidget();
    } else {
      return NoTokoYetWidget();
    }
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
