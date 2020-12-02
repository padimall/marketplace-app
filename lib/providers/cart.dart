import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/models/post_show_checkout_info.dart';
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

  bool _isCheckedAllCart;

  bool get isCheckedAllCart => _isCheckedAllCart;

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
          _isCheckedAllCart = false;
          _listUserCart.addAll(jsonObject.data);
          countApproximatePrice();
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

  void updateSelectionCartByCartId(String cartId, bool isChecked) {
    _listUserCart.forEach((cart) {
      int _selectedOrderCount = 0;

      cart.orders.forEach((order) {
        if (order.cartId == cartId) {
          order.isSelected = isChecked;
        }
        if (order.isSelected) _selectedOrderCount++;
      });

      if (_selectedOrderCount == cart.orders.length) {
        cart.isSelected = true;
      } else {
        cart.isSelected = false;
      }
    });
    updateIsCheckedAllCartValue();
    countApproximatePrice();
    notifyListeners();
  }

  void updateSelectedCartGroupedByAgent(String agentId, bool isChecked) {
    _listUserCart.forEach((cart) {
      if (cart.agent.id == agentId) {
        cart.isSelected = isChecked;
        cart.orders.forEach((order) {
          order.isSelected = isChecked;
        });
      }
    });
    updateIsCheckedAllCartValue();
    countApproximatePrice();
    notifyListeners();
  }

  void setIsCheckedAllCart(bool isChecked) {
    _isCheckedAllCart = isChecked;
    _listUserCart.forEach((cart) {
      cart.isSelected = isChecked;
      cart.orders.forEach((order) {
        order.isSelected = isChecked;
      });
    });
    countApproximatePrice();
    notifyListeners();
  }

  void updateIsCheckedAllCartValue() {
    bool _isAnyCartUnchecked = false;
    _listUserCart.forEach((cart) {
      if (!cart.isSelected) {
        _isAnyCartUnchecked = true;
        return;
      }
    });
    _isCheckedAllCart = !_isAnyCartUnchecked;
  }

  int _approximatePrice = 0;
  int _totalQuantityItemChecked = 0;

  int get approximatePrice => _approximatePrice;

  int get totalQuantityItemChecked => _totalQuantityItemChecked;

  void countApproximatePrice() {
    _approximatePrice = 0;
    _totalQuantityItemChecked = 0;
    _listUserCart.forEach((cart) {
      cart.orders.forEach((order) {
        if (order.isSelected) {
          _approximatePrice += order.quantity * order.price;
          _totalQuantityItemChecked += order.quantity;
        }
      });
    });
  }

  String getSelectedCartJsonArray() {
    List<String> _listSelectedCart = [];
    _listUserCart.forEach((cart) {
      cart.orders.forEach((order) {
        if (order.isSelected) {
          _listSelectedCart.add(order.cartId);
        }
      });
    });
    print(jsonEncode(_listSelectedCart));
    return jsonEncode(_listSelectedCart);
  }

  CheckoutDetail _checkoutDetail;

  CheckoutDetail get checkoutDetail => _checkoutDetail;

  Future<void> getCheckoutInformation(BuildContext context) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/checkout/user';
      print(url);

      var requestBody = {
        'carts': getSelectedCartJsonArray(),
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

      var jsonObject = PostResCheckoutInfo.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _checkoutDetail = jsonObject.data;
      } else {
        Fluttertoast.showToast(msg: "Terjadi kesalahan. Error code: ${response.statusCode}", backgroundColor: Theme.of(context).accentColor);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  void setLogisticSelection(String agentId, Logistic selectedLogistic) {
    print('a: ${agentId}');

    _checkoutDetail.checkouts.forEach((checkoutPerAgent) {
      print('azz: ${checkoutPerAgent.agent.id}');
      if (checkoutPerAgent.agent.id == agentId) {
        checkoutPerAgent.logistic = selectedLogistic;
        return;
      }
    });

    notifyListeners();
  }
}
