import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:padimall_app/models/post_show_supplier_detail.dart';
import 'package:padimall_app/models/post_show_suppliers_agent_detail.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import 'package:padimall_app/utils/global.dart' as global;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class ProviderToko with ChangeNotifier {
  Future<void> createSupplier(
      BuildContext context, String name, String address, String phone, String nib, TextEditingController agentCodeController, File selectedImage) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/supplier/store';
      print(url);

      String _pictureFilename;
      if (selectedImage != null) {
        _pictureFilename = selectedImage.path.split('/').last;
      }

      // HTTP
//      var requestBody = {
//        'name': name,
//        'phone': phone,
//        'nib': nib,
//        'address': address,
//        'agent_code': agentCodeController.text,
//        'image': selectedImage == null
//            ? null
//            : base64Image,
//      };
//
//      http.Response response = await http.post(
//        url,
//        headers: {
//          'X-Requested-With': 'XMLHttpRequest',
//          'Content-Type': 'application/json',
//          'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getUserToken(),
//        },
//        body: json.encode(requestBody),
//      );
//      print(response.body);
//      print(response.statusCode);

      // DIO
      var dio = Dio();
      FormData formData = FormData.fromMap({
        'name': name,
        'phone': phone,
        'nib': nib,
        'address': address,
        'agent_code': agentCodeController.text,
        'image': selectedImage == null ? null : await MultipartFile.fromFile(selectedImage.path, filename: _pictureFilename),
      });
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
//            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getUserToken(),
          },
        ),
      );

      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: 'Anda berhasil menjadi Supplier.', toastLength: Toast.LENGTH_LONG, backgroundColor: Colors.grey);
        Navigator.pop(context);
        getSupplierDetail(context);
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: 'Kode Agent tidak cocok.', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).accentColor);
        agentCodeController.clear();
      } else if (response.statusCode == 422) {
        Fluttertoast.showToast(
            msg: 'Format Gambar salah. (Hanya menerima png, jpg, jpeg).', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).accentColor);
      }
    } on DioError catch (dioError) {
      // Something happened in setting up or sending the request that triggered an Error
      print(dioError.request);
      print(dioError.message);
      print(dioError.toString());
      print(dioError.response);
    } finally {
      Navigator.pop(context);
      notifyListeners();
    }
  }

  SupplierDetail _supplierDetail;

  SupplierDetail get supplierDetail => _supplierDetail;

  Future<void> getSupplierDetail(BuildContext context) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/supplier/detail';
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

      var jsonObject = PostResShowSupplierDetail.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _supplierDetail = jsonObject.data;
      } else if (response.statusCode == 404) {
        _supplierDetail = null;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Agent _agentDetail;

  Agent get agentDetail => _agentDetail;

  Future<void> getSuppliersAgentInfo() async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/supplier/my-agent';
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

      var jsonObject = PostRestSuppliersAgentDetail.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _agentDetail = jsonObject.data;
      } else if (response.statusCode == 404) {
        _agentDetail = null;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
