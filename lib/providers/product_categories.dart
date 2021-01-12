import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:padimall_app/models/post_show_product_main_categories.dart';
import 'package:padimall_app/models/post_show_products.dart';
import 'package:padimall_app/models/post_show_sub_product_category.dart';
import 'package:padimall_app/models/product_main_category.dart';
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import '../utils/global.dart' as global;
import 'package:padimall_app/models/post_show_product_categories.dart';

class ProviderProductCategories with ChangeNotifier {
  int _selectedMainCategoryIndex = 0;

  int get selectedMainCategoryIndex => _selectedMainCategoryIndex;

  void setSelectedMainCategoryIndex(int value) {
    _selectedMainCategoryIndex = value;
    notifyListeners();
  }

  List<ProductCategory> _listProductCategories = [];

  List<ProductCategory> get listProductCategories => _listProductCategories;

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
        _listProductCategories.clear();
        _listProductCategories.addAll(jsonObject.data);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  List<ProductMainCategory> _listMainCategories = [];

  List<ProductMainCategory> get listMainCategories => _listMainCategories;

  Future<void> getMainAndSubProductCategories() async {
    try {
      // GET PRODUCT MAIN CATEGORY
      var url = '${global.API_URL_PREFIX}/api/v1/main-category/all';

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
      var jsonObject = PostResMainCategories.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        _listMainCategories.clear();
        _listMainCategories.addAll(jsonObject.data);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> getMainProductCategories() async {
    try {
      // GET PRODUCT MAIN CATEGORY
      var url = '${global.API_URL_PREFIX}/api/v1/main-category/all';

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
      var jsonObject = PostResMainCategories.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        _listMainCategories.clear();
        _listMainCategories.addAll(jsonObject.data);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> getSubCategoryFromMainCategory(int indexMainCategory) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/main-category/sub';

      var requestBody = {'target_id': _listMainCategories[indexMainCategory].id};

      http.Response response = await http.post(url,
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getDevToken(),
          },
          body: json.encode(requestBody));
      print(url);
      print(response.body);
      var jsonObject = PostResProductSubCategories.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        _listMainCategories[indexMainCategory].productCategories = [];
        if (jsonObject.status == 1) {
          _listMainCategories[indexMainCategory].productCategories.addAll(jsonObject.data);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<Product> _listProduct = [];

  List<Product> get listProduct => _listProduct;

  Future<void> getProductByCategory(ProductCategory productCategory) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/product/category';

      var requestBody = {
        'name': productCategory.name,
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
      print(response.statusCode);
      var jsonObject = PostResShowProducts.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        _listProduct.clear();
        _listProduct.addAll(jsonObject.data);
      } else if (response.statusCode == 404) {
        _listProduct.clear();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
