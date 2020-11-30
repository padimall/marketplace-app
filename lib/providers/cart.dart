import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/models/post_show_products.dart';
import 'package:padimall_app/models/post_show_user_cart.dart';
import 'package:http/http.dart' as http;
import 'package:padimall_app/screens/keranjang_screen.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/custom_text_theme.dart';
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import 'package:padimall_app/utils/global.dart' as global;

class ProviderCart with ChangeNotifier {
  List<Cart> _listUserCart = [];

  List<Cart> get listUserCart => _listUserCart;

  Future<void> getUserCart(BuildContext context) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/cart/user';
      print(url);

      print('tes ya: ${await FlutterSecureStorageServices.getUserToken()}');

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

  Future<void> addProductWithMinOrderToCart(BuildContext context, Product product) async {
    try {
      CustomAlertDialog.loading(context);
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

      Navigator.pop(context);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Flushbar(
          title: 'Keranjang diperbaharui',
          message: '${product.name} telah ditambahkan ke keranjang',
          mainButton: FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, KeranjangScreen.routeName);
            },
            child: Text(
              "Lihat",
              style: PadiMallTextTheme.sz14weight700Green(context),
            ),
          ),
          duration: Duration(seconds: 5),
        )..show(context);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteProductFromCart(BuildContext context, String cartId) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/cart/delete';
      print(url);
      print(cartId);

      var requestBody = {
        'target_id': cartId,
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

      Navigator.pop(context);
      if (response.statusCode == 200) {
        getUserCart(context);
      } else {
        Fluttertoast.showToast(msg: "Terjadi kesalahan. Error code: ${response.statusCode}", backgroundColor: Theme.of(context).accentColor);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateCartQty(BuildContext context, String cartId, int itemQty) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/cart/update';
      print(url);
      print(cartId);

      var requestBody = {
        'target_id': cartId,
        'quantity': itemQty,
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

      if (response.statusCode == 200) {
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
