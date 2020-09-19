import 'package:flutter/material.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/akun/no_user_yet.dart';
import 'package:padimall_app/widgets/keranjang/bottom_bar.dart';
import 'package:padimall_app/widgets/keranjang/toko.dart';
import 'package:provider/provider.dart';

class KeranjangScreen extends StatelessWidget {
  static final routeName = 'keranjang-screen';
  ProviderUser _providerUser;

  @override
  Widget build(BuildContext context) {
    _providerUser = Provider.of(context, listen: false);

    return buildFutureBuilder(
      _providerUser.checkIsUserLogin(),
      Consumer<ProviderUser>(
        builder: (ctx, provider, _) => Scaffold(
          appBar: AppBar(
            title: Text(
              'Keranjang',
              style: PadiMallTextTheme.sz16weight700(context),
            ),
            elevation: _providerUser.isUserLogin ? 0 : 1,
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          backgroundColor: _providerUser.isUserLogin ? Colors.grey[100] : Colors.white,
          body: !_providerUser.isUserLogin
              ? NoUserYetWidget()
              : Column(
                  children: <Widget>[
                    Material(
                      color: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              value: true,
                              onChanged: (value) {},
                            ),
                            Text(
                              'Pilih semua barang',
                              style: PadiMallTextTheme.sz13weight500(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          itemCount: 2,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            return KeranjangTokoWidget();
                          },
                        ),
                      ),
                    ),
                    KeranjangBottomBarWidget(),
                  ],
                ),
        ),
      ),
    );
  }
}
