import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:padimall_app/models/post_show_products.dart';
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import '../utils/global.dart' as global;

class ProviderProduct with ChangeNotifier {
  List<Product> _listProduct = [];

  List<Product> get listProduct => _listProduct;

  Future<void> getProducts() async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/product/limit';

      var requestBody = {
        'limit': 10,
      };

      http.Response response = await http.post(url,
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getDevToken(),
          },
          body: json.encode(requestBody));
      print(url);
      print(response.body);
      var jsonObject = PostResShowProducts.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        _listProduct.clear();
        _listProduct.addAll(jsonObject.data);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Product _selectedProduct;

  Product get selectedProduct => _selectedProduct;

}
