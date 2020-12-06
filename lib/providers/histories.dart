import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/models/post_show_user_invoice_list.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import 'package:padimall_app/utils/global.dart' as global;
import 'package:http/http.dart' as http;

class ProviderHistories with ChangeNotifier {
  int _selectedStagePenjualanIndex = 0;

  int get selectedStagePenjualanIndex => _selectedStagePenjualanIndex;

  void setSelectedStagePenjualanIndex(int index) {
    _selectedStagePenjualanIndex = index;
    notifyListeners();
  }

  int _selectedStagePembelianIndex = 0;

  int get selectedStagePembelianIndex => _selectedStagePembelianIndex;

  void setSelectedStagePembelianIndex(int index) {
    _selectedStagePembelianIndex = index;
    notifyListeners();
  }

  List<InvoiceGroup> _listInvoiceSummaries = [];

  List<InvoiceGroup> get listInvoiceSummaries => _listInvoiceSummaries;

  Future<void> getUserInvoiceHistories(BuildContext context) async {
    try {

      var url = '${global.API_URL_PREFIX}/api/v1/invoice/list';
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

      var jsonObject = PostResUserInvoiceList.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _listInvoiceSummaries.clear();
        if (jsonObject.status == 1) {
          _listInvoiceSummaries.addAll(jsonObject.invoiceGroups);
        }
      } else if (response.statusCode == 401) {
        CustomAlertDialog.endOfSession(context);
      } else {
        Fluttertoast.showToast(msg: "Terjadi kesalahan. Error code: ${response.statusCode}", backgroundColor: Theme.of(context).accentColor);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
