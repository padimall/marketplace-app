import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:padimall_app/models/post_show_products.dart';
import 'package:padimall_app/models/post_show_user_cart.dart';
import 'package:http/http.dart' as http;
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import 'package:padimall_app/utils/global.dart' as global;

class ProviderCart with ChangeNotifier {
  List<Cart> _listUserCart = [];

  List<Cart> get listUserCart => _listUserCart;

  Future<void> getUserCart() async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/cart/user';
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

      var jsonObject = PostResShowUserCart.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _listUserCart.clear();
        if (jsonObject.status == 1) {
          _listUserCart.addAll(jsonObject.data);
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> addProductWithMinOrderToCart(Product product) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/cart/store';
      print(url);

      var requestBody = {
        'product_id': product.id,
        'quantity': product.minOrder,
        'status': 1,
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

//      var jsonObject = PostResShowUserCart.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {}
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
