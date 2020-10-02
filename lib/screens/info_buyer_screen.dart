import 'package:flutter/material.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/info_user/edit_dialog.dart';
import 'package:provider/provider.dart';

class InfoBuyerScreen extends StatelessWidget {
  static final routeName = 'info-buyer-screen';
  ProviderUser _providerUser;

  @override
  Widget build(BuildContext context) {
    _providerUser = Provider.of<ProviderUser>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informasi Akun',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
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
      body: buildFutureBuilder(
        _providerUser.getUserProfile(context),
        Consumer<ProviderUser>(
          builder: (ctx, provider, _) => Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildInfoRow(context, 'Nama', '${_providerUser.userProfileDetail.name}', 0),
                  _buildInfoRow(context, 'No. Handphone', '${_providerUser.userProfileDetail.phone}', 1),
                  _buildInfoRow(context, 'Email', '${_providerUser.userProfileDetail.email}', 2),
                  _buildInfoRow(context, 'Alamat Lengkap', '${_providerUser.userProfileDetail.address}', 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, int indexProfile) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '$label',
                    style: PadiMallTextTheme.sz11weight500(context),
                  ),
                ),
                Text(
                  '$value',
                  style: PadiMallTextTheme.sz13weight600Soft(context),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => EditBuyerDialogWidget.show(context, label, value, indexProfile),
            child: Icon(
              Icons.edit,
              size: 20,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
