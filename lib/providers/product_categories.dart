import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import '../utils/global.dart' as global;
import 'package:padimall_app/models/post_show_product_categories.dart';

class ProviderProductCategories with ChangeNotifier {
  List<ProductCategories> _listProductCategories = [];

  List<ProductCategories> get listProductCategories => _listProductCategories;

  Future<void> getProductCategories() async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/product-category/all';

      http.Response response = await http.post(
        url,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getDevToken(),
        },
      );
      print(url);
      print(response.body);
      var jsonObject = PostResShowProductCategories.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        _listProductCategories.addAll(jsonObject.data);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
