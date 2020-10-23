import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_supplier_detail.dart';
import 'package:padimall_app/models/post_show_suppliers_agent_detail.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/screens/info_toko_edit_screen.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:provider/provider.dart';

class InfoAgentScreen extends StatelessWidget {
  static final routeName = 'info-agent-screen';
  ProviderToko _providerToko;

  @override
  Widget build(BuildContext context) {
    _providerToko = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informasi Agen',
          style: PadiMallTextTheme.sz16weight700(context),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 15,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildAgentInfo(context),
            _buildListOfSuppliers(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAgentInfo(BuildContext context) {
    return Consumer<ProviderToko>(
      builder: (ctx, provider, _) {
        Agent _agentDetail = _providerToko.agentDetail;

        return Container(
          color: Colors.white,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Agen',
                      style: PadiMallTextTheme.sz14weight600Soft(context),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, InfoTokoEditScreen.routeName);
                    },
                    child: Text(
                      'Ubah',
                      style: PadiMallTextTheme.sz12weight600Green(context),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: _agentDetail.imageUrl == null
                          ? Image.asset(
                              'assets/images/no_image.png',
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            )
                          : FadeInImage.assetNetwork(
                              image: '${_agentDetail.imageUrl}',
                              fit: BoxFit.cover,
                              placeholder: 'assets/images/logo.png',
                              height: 60,
                              width: 60,
                            ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            '${_agentDetail.name}',
                            style: PadiMallTextTheme.sz14weight600Soft(context),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.call,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ),
                            Text(
                              '${_agentDetail.phone}',
                              style: PadiMallTextTheme.sz12weight500Grey(context),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.vpn_key,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ),
                            Text(
                              '${_agentDetail.agentCode}',
                              style: PadiMallTextTheme.sz12weight500Grey(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListOfSuppliers(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            'Supplier Saya',
            style: PadiMallTextTheme.sz14weight600Soft(context),
          ),
        ),
        ListView.builder(
          itemCount: _providerToko.agentDetail.suppliers.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var supplier = _providerToko.agentDetail.suppliers[index];

            print("is : ${supplier.imageUrl == null}");
            return Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: supplier.imageUrl == null
                              ? Image.asset(
                                  'assets/images/no_image.png',
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                )
                              : FadeInImage.assetNetwork(
                                  image: '${supplier.imageUrl}',
                                  fit: BoxFit.cover,
                                  placeholder: 'assets/images/logo.png',
                                  height: 60,
                                  width: 60,
                                ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                '${supplier.name}',
                                style: PadiMallTextTheme.sz14weight600Soft(context),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(right: 4),
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.grey,
                                    size: 15,
                                  ),
                                ),
                                Text(
                                  '${supplier.phone}',
                                  style: PadiMallTextTheme.sz12weight500Grey(context),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(right: 4),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 15,
                                  ),
                                ),
                                Text(
                                  '${supplier.address}',
                                  style: PadiMallTextTheme.sz12weight500Grey(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
            style: PadiMallTextTheme.sz12weight600Soft(context),
          ),
        ],
      ),
    );
  }
}
