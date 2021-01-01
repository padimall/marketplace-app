import 'package:flutter/material.dart';
import 'package:padimall_app/models/post_show_suppliers_agent_detail.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/utils/build_future_builder.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:provider/provider.dart';

class TokoDetailWidget extends StatelessWidget {
  ProviderToko providerToko;

  Agent agent;

  TokoDetailWidget({this.agent});

  @override
  Widget build(BuildContext context) {
    providerToko = Provider.of(context, listen: false);
    return buildFutureBuilder(
      providerToko.getAgentDetailById(context, agent.id),
      Consumer<ProviderToko>(
        builder: (ctx, provider, _) => Container(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: providerToko.tokoDetail.imageUrl == null
                        ? Image.asset(
                            'assets/images/no_image.png',
                            height: 75,
                            width: 75,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            '${providerToko.tokoDetail.imageUrl}',
                            fit: BoxFit.cover,
                            height: 75,
                            width: 75,
                          ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${providerToko.tokoDetail.name}',
                        style: PadiMallTextTheme.sz14weight600(context),
                      ),
                      if (providerToko.tokoDetail.address != null)
                        Text(
                          '${providerToko.tokoDetail.address}',
                          style: PadiMallTextTheme.sz12weight500(context),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
