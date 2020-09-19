import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:padimall_app/models/post_login_dev.dart';
import 'package:padimall_app/screens/first_screen.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import '../utils/global.dart' as global;

class ProviderUser with ChangeNotifier {
  Future<void> signInDeveloper(BuildContext context) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/login-dev';

      var requestBody = {
        'email': 'dev@gmail.com',
        'password': 'testtest',
        'remember_me': true,
        'keyword': 'P@d1Mall-@p1',
      };

      http.Response response = await http.post(
        url,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );
      print(url);
      print(response.body);
      var jsonObject = PostResLoginDev.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        FlutterSecureStorageServices.setDevToken(jsonObject.accessToken);
      }
    } catch (e) {
      print(e.toString());
    } finally {
//      Navigator.pop(context);
    }
  }

  Future<void> signUpUser(
      BuildContext context, String name, String address, String email, String phoneNum, String password, String passwordConfirmation) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/buyer';
      var requestBody = {
        'request_type': 3,
        'username': name,
        'address': address,
        'email': email,
        'phone': phoneNum,
        'password': password,
      };

      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getDevToken(),
        },
        body: json.encode(requestBody),
      );
      print(response.body);

      if (response.statusCode == 201) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Akun berhasil dibuat, silahkan login', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.grey);
      } else {
        print(response.statusCode);
        Fluttertoast.showToast(msg: response.statusCode.toString(), toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      Navigator.pop(context);
    }
  }

  Future<void> signInUser(BuildContext context, String email, String password) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/login';

      var requestBody = {
        'email': email,
        'password': password,
        'remember_me': true,
      };

      http.Response response = await http.post(
        url,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getDevToken(),
        },
        body: json.encode(requestBody),
      );
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        Navigator.pushNamedAndRemoveUntil(context, FirstScreen.routeName, (Route<dynamic> route) => false);
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Email dan Password tidak cocok', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).accentColor);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      Navigator.pop(context);
    }
  }
}
