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

      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Kode Agent tidak cocok.', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).accentColor);
        agentCodeController.clear();
      } else if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: 'Anda berhasil menjadi Supplier.', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
        Navigator.pop(context);
        getSupplierDetail(context);
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

  Supplier _supplierDetail;

  Supplier get supplierDetail => _supplierDetail;

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
      } else {
        _agentDetail = null;
        if (response.statusCode == 401) {
          CustomAlertDialog.endOfSession(context);
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Agent _agentDetail;

  Agent get agentDetail => _agentDetail;

  Agent _agentOfSupplier;

  Agent get agentOfSupplier => _agentOfSupplier;

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

      var jsonObject = PostResSuppliersAgentDetail.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _agentOfSupplier = jsonObject.data;
      } else if (response.statusCode == 404) {
        _agentOfSupplier = jsonObject.data;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateSupplierProfile(BuildContext context, TextEditingController textEditingController, int indexProfile) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/supplier/update';
      var requestBody = {
        'name': indexProfile == 0 ? textEditingController.text : null,
        'phone': indexProfile == 1 ? textEditingController.text : null,
        'address': indexProfile == 2 ? textEditingController.text : null,
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
        Fluttertoast.showToast(msg: 'Data berhasil diperbaharui', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
        getSupplierDetail(context);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<void> updateImage(BuildContext context, File selectedImage, String type) async {
    try {
      CustomAlertDialog.loading(context);
      var dio = Dio();
      var url = '${global.API_URL_PREFIX}/api/v1/$type/update';
      print(url);
      FormData formData = FormData.fromMap({
        'image': selectedImage == null ? null : await MultipartFile.fromFile(selectedImage.path, filename: selectedImage.path.split('/').last),
      });
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getUserToken(),
          },
        ),
      );

      print(response.statusCode);
      print(response.data);

      Navigator.pop(context);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Foto berhasil diperbaharui', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      if (type == "supplier") {
        getSupplierDetail(context);
      } else if (type == "agent") {
        getAgentDetail(context);
      }
    }
  }

  Future<void> deleteImage(BuildContext context, String type) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/$type/delete-image';
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

      Navigator.pop(context);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Data berhasil diperbaharui', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
      } else {
        Fluttertoast.showToast(
            msg: 'Terjadi kesalahan. ${response.statusCode}', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).accentColor);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      if (type == "supplier") {
        getSupplierDetail(context);
      } else if (type == "agent") {
        getAgentDetail(context);
      }
    }
  }

  Future<void> getAgentDetail(BuildContext context) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/agent/detail';
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

      var jsonObject = PostResSuppliersAgentDetail.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _agentDetail = jsonObject.data;
      } else {
        _agentDetail = null;
        if (response.statusCode == 401) {
          CustomAlertDialog.endOfSession(context);
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateAgentProfile(BuildContext context, TextEditingController textEditingController, int indexProfile) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/agent/update';

      var requestBody = {
        'name': indexProfile == 0 ? textEditingController.text : null,
        'address': indexProfile == 1 ? textEditingController.text : null,
        'phone': indexProfile == 2 ? textEditingController.text : null,
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
        Fluttertoast.showToast(msg: 'Data berhasil diperbaharui', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
        getAgentDetail(context);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      Navigator.pop(context);
      notifyListeners();
    }
  }

  Future<void> createAgent(BuildContext context, String agentName, String address, String phoneNumber, File selectedImage) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/agent/store';
      print(url);

      String _pictureFilename;
      if (selectedImage != null) {
        _pictureFilename = selectedImage.path.split('/').last;
      }

      var dio = Dio();
      FormData formData = FormData.fromMap({
        'name': agentName,
        'phone': phoneNumber,
        'address': address,
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
      print(response.data);

      if (response.statusCode == 201) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Pendaftaran anda sedang diproses.', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
        getAgentDetail(context);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      Navigator.pop(context);
      notifyListeners();
    }
  }
}
