import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/models/post_show_supplier_detail.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/widgets/supplier/supplier_widget.dart';
import 'package:provider/provider.dart';

class ListSupplierProductScreen extends StatelessWidget {
  static final routeName = 'list-supplier-product-screen';
  ProviderToko _providerToko;

  @override
  Widget build(BuildContext context) {
    _providerToko = Provider.of<ProviderToko>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Supplier Anda',
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.search,
                    size: 15,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffix: Icon(
                        Icons.clear,
                        size: 15,
                      ),
                      hintText: 'Cari nama supplier anda',
                      hintStyle: PadiMallTextTheme.sz14weight500Grey(context),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: buildFutureBuilder(
        _providerToko.getAgentDetail(context),
        Consumer<ProviderToko>(
          builder: (ctx, provider, _) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                ),
                itemCount: _providerToko.agentDetail.suppliers.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return _providerToko.agentDetail.suppliers.isEmpty
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 40),
                                child: SvgPicture.asset(
                                  'assets/images/empty.svg',
                                  height: 200,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20, bottom: 20),
                                child: Text(
                                  'Anda belum memiliki Supplier',
                                  textAlign: TextAlign.center,
                                  style: PadiMallTextTheme.sz14weight500(context),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SupplierWidget(
                          supplier: _providerToko.agentDetail.suppliers[index],
                        );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
