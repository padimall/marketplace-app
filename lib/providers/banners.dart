import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:padimall_app/models/post_show_banners.dart';
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import 'package:padimall_app/utils/global.dart' as global;
import 'package:http/http.dart' as http;

class ProviderBanner with ChangeNotifier {
  List<NewsBanner> _listBanner = [];

  List<NewsBanner> get listBanner => _listBanner;

  Future<void> getBannerList(BuildContext context) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/banner/all';
      print(url);

      http.Response response = await http.post(
        url,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      print(response.statusCode);

      var jsonObject = PostShowBanner.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _listBanner.clear();
        if (jsonObject.status == 1) {
          _listBanner.addAll(jsonObject.data);
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
