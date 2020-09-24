import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/models/post_show_supplier_detail.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import 'package:padimall_app/utils/global.dart' as global;
import 'package:http/http.dart' as http;

class ProviderToko with ChangeNotifier {
  Future<void> createSupplier(BuildContext context, String name, String phone, String nib, TextEditingController agentCodeController) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/supplier/store';
      print(url);

      var requestBody = {
        'name': name,
        'phone': phone,
        'nib': nib,
        'agent_code': agentCodeController.text,
      };

      http.Response response = await http.post(
        url,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getUserToken(),
        },
        body: json.encode(requestBody),
      );
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: 'Anda berhasil menjadi Supplier.', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.grey);
        Navigator.pop(context);
        getSupplierDetail(context);
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: 'Kode Agent tidak cocok.', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).accentColor);
        agentCodeController.clear();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      Navigator.pop(context);
      notifyListeners();
    }
  }

  SupplierDetail _supplierDetail;

  SupplierDetail get supplierDetail => _supplierDetail;

  Future<void> getSupplierDetail(BuildContext context) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/supplier/detail';
      print(url);

      http.Response response = await http.post(
        url,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getUserToken(),
        },
      );
      print(response.body);
      print(response.statusCode);

      var jsonObject = PostResShowSupplierDetail.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _supplierDetail = jsonObject.data;
      } else if (response.statusCode == 404) {
        _supplierDetail = null;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
