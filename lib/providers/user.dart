import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:padimall_app/models/post_login_dev.dart';
import 'package:padimall_app/models/post_show_supplier_detail.dart';
import 'package:padimall_app/models/post_show_user_profile.dart';
import 'package:padimall_app/screens/first_screen.dart';
import 'package:padimall_app/screens/forgot_pass_sent_screen.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/custom_logic.dart';
import 'package:padimall_app/utils/firebase_messaging_services.dart';
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
      var jsonObject = PostResLogin.fromJson(json.decode(response.body));

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
      var url = '${global.API_URL_PREFIX}/api/v1/signup';
      var requestBody = {
        'name': name,
        'email': email,
        'address': address,
        'phone': phoneNum,
        'password': password,
        'password_confirmation': passwordConfirmation,
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
        Fluttertoast.showToast(msg: 'Akun berhasil dibuat, silahkan login', toastLength: Toast.LENGTH_LONG, backgroundColor:  Theme.of(context).primaryColor);
      } else if (response.statusCode == 422) {
        if (response.body.contains('The email has already been taken')) {
          Fluttertoast.showToast(msg: "Email telah digunakan", toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).accentColor);
        } else if (response.body.contains('phone')) {
          Fluttertoast.showToast(msg: "No. HP telah terdaftar", toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).accentColor);
        }
      } else {
        Fluttertoast.showToast(msg: response.statusCode.toString(), toastLength: Toast.LENGTH_LONG, backgroundColor:  Theme.of(context).accentColor);
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
        'email_or_phone': email,
        'password': password,
        'remember_me': true,
        'device_id': await FirebaseMessagingService.getDeviceToken(),
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

      Navigator.pop(context);

      var jsonObject = PostResLogin.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        FlutterSecureStorageServices.setUserToken(jsonObject.accessToken);
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, FirstScreen.routeName, (Route<dynamic> route) => false);
        }
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Email dan Password tidak cocok', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).accentColor);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      await checkIsUserLogin();
    }
  }

  bool _isUserLogin;

  bool get isUserLogin => _isUserLogin;

  Future<void> checkIsUserLogin() async {
    _isUserLogin = await CustomLogic.isUserTokenExist();
    notifyListeners();
  }

  UserProfileDetail _userProfileDetail;

  UserProfileDetail get userProfileDetail => _userProfileDetail;

  Future<void> getUserProfile(BuildContext context) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/user';
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

      var userDetailJson = UserProfileDetail.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _userProfileDetail = userDetailJson;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateUserProfile(BuildContext context, TextEditingController textEditingController, int indexProfile) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/user/update';

      var requestBody = {
        'name': indexProfile == 0 ? textEditingController.text : null,
        'phone': indexProfile == 1 ? textEditingController.text : null,
        'email': indexProfile == 2 ? textEditingController.text : null,
        'address': indexProfile == 3 ? textEditingController.text : null,
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
      print(requestBody);
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Data berhasil diperbaharui', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
        getUserProfile(context);
      } else if (response.statusCode == 422) {
        Navigator.pop(context);
        if (response.body.contains('phone')) {
          Fluttertoast.showToast(
              msg: 'Gagal mengupdate. No. Handphone telah terdaftar', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).accentColor);
        } else if (response.body.contains('email')) {
          Fluttertoast.showToast(
              msg: 'Gagal mengupdate. Email telah terdaftar', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).accentColor);
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<void> changePasswordUser(BuildContext context, TextEditingController oldPassword, TextEditingController newPassword) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/user/change-password';

      var requestBody = {
        'old_password': oldPassword.text,
        'password': newPassword.text,
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
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Password berhasil diperbaharui', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
        getUserProfile(context);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<void> forgotPassword(BuildContext context, String email) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/password/forgot';
      print(url);

      var requestBody = {
        'email': email,
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

      Navigator.pop(context);
      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, ForgotPassSentScreen.routeName, arguments: email);
      } else if (response.statusCode == 422) {
        Fluttertoast.showToast(msg: 'Email tidak terdaftar', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).accentColor);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

}
