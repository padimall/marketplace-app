import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:padimall_app/screens/first_screen.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import '../utils/global.dart' as global;

class ProviderUser with ChangeNotifier {
  Future<void> signUpUser(BuildContext context, String name, String email, String phoneNum,
      String password, String passwordConfirmation) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/buyer';
      var requestBody = {
        'request_type': 3,
        'username': name,
        'email': email,
        'phone': phoneNum,
        'password': password,
        'address': 'Jalan Jalan',
//        'password_confirmation': passwordConfirmation,
      };

      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );
      print(response.body);

      if (response.statusCode == 201) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: 'Akun berhasil dibuat, silahkan login',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.grey);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      Navigator.pop(context);
    }
  }

  Future<void> signInuser(
      BuildContext context, String email, String password) async {
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
        },
        body: json.encode(requestBody),
      );
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        Navigator.pushNamedAndRemoveUntil(
            context, FirstScreen.routeName, (Route<dynamic> route) => false);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      Navigator.pop(context);
    }
  }
}
