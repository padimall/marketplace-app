import 'package:flutter/cupertino.dart';
import 'package:padimall_app/providers/toko.dart';
import 'package:padimall_app/providers/user.dart';
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import 'package:provider/provider.dart';

class CustomLogic {
  static Future<bool> isUserTokenExist() async {
    var _token = await FlutterSecureStorageServices.getUserToken();
    if (_token != null) {
      return true;
    }
    return false;
  }

  static bool isThisProductBelongToThisUser(BuildContext context, String supplierId, String agentId) {
    bool result = false;
    try {
      ProviderToko _providerToko;
      _providerToko = Provider.of(context, listen: false);

      if (_providerToko.agentDetail != null) {
        if (_providerToko.agentDetail.id == agentId) {
          result = true;
        }
      } else if (_providerToko.supplierDetail != null) {
        if (_providerToko.supplierDetail.id == supplierId) {
          result = true;
        }
      }

    } catch (e) {
      print(e);
    }
    return result;
  }
}
