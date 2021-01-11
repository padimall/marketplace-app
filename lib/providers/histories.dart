import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mime/mime.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:padimall_app/models/post_show_agent_invoice_list.dart';
import 'package:padimall_app/models/post_show_invoice_detail.dart';
import 'package:padimall_app/models/post_show_invoice_group_detail.dart';
import 'package:padimall_app/models/post_show_invoice_pay.dart';
import 'package:padimall_app/models/post_show_user_invoice_list.dart';
import 'package:padimall_app/models/rating_product.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import 'package:padimall_app/utils/global.dart' as global;
import 'package:http/http.dart' as http;

class ProviderHistories with ChangeNotifier {
  int _selectedStagePenjualanIndex = 0;

  int get selectedStagePenjualanIndex => _selectedStagePenjualanIndex;

  void setSelectedStagePenjualanIndex(int index) {
    _selectedStagePenjualanIndex = index;
    notifyListeners();
  }

  int _selectedStagePembelianIndex = 0;

  int get selectedStagePembelianIndex => _selectedStagePembelianIndex;

  void setSelectedStagePembelianIndex(int index) {
    _selectedStagePembelianIndex = index;
    notifyListeners();
  }

  List<InvoiceGroup> _listInvoiceSummaries = [];

  List<InvoiceGroup> get listInvoiceSummaries => _listInvoiceSummaries;

  Future<void> getBuyerInvoiceHistories(BuildContext context) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/invoice/list';
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

      var jsonObject = PostResUserInvoiceList.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _listInvoiceSummaries.clear();
        if (jsonObject.status == 1) {
          _listInvoiceSummaries.addAll(jsonObject.invoiceGroups);
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

  List<InvoiceSummary> _listInvoiceSeller = [];

  List<InvoiceSummary> get listInvoiceSeller => _listInvoiceSeller;

  Future<void> getAgentInvoiceHistories(BuildContext context) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/invoice/seller';
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

      var jsonObject = PostResAgentInvoiceList.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _listInvoiceSeller.clear();
        if (jsonObject.status == 1) {
          _listInvoiceSeller.addAll(jsonObject.data);
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

  InvoiceDetail _invoiceDetail;

  InvoiceDetail get invoiceDetail => _invoiceDetail;

  Future<void> getInvoiceDetail(BuildContext context, String invoiceId) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/invoice/detail';
      print(url);

      var requestBody = {
        'target_id': invoiceId,
      };

      http.Response response = await http.post(
        url,
        body: json.encode(requestBody),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getUserToken(),
        },
      );
      print(response.body);
      print(response.statusCode);

      var jsonObject = PostResShowInvoiceDetail.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        if (jsonObject.status == 1) {
          _invoiceDetail = jsonObject.data;
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

  InvoiceGroupDetail _invoiceGroupDetail;

  InvoiceGroupDetail get invoiceGroupDetail => _invoiceGroupDetail;

  Future<void> getInvoiceGroupDetail(BuildContext context, String invoiceGroupId) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/invoice/group-detail';
      print(url);

      print(invoiceGroupId);
      var requestBody = {
        'target_id': invoiceGroupId,
      };

      http.Response response = await http.post(
        url,
        body: json.encode(requestBody),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getUserToken(),
        },
      );
      print(response.body);
      print(response.statusCode);

      var jsonObject = PostResInvoiceGroupDetail.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        if (jsonObject.status == 1) {
          _invoiceGroupDetail = jsonObject.data;
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

  InvoicePayment _invoicePayment;

  InvoicePayment get invoicePayment => _invoicePayment;

  Future<void> getInvoicePaymentDetail(BuildContext context, String invoiceGroupId) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/invoice/pay';
      print(url);

      print(invoiceGroupId);
      var requestBody = {
        'target_id': invoiceGroupId,
      };

      http.Response response = await http.post(
        url,
        body: json.encode(requestBody),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getUserToken(),
        },
      );
      print(response.body);
      print(response.statusCode);

      var jsonObject = PostResInvoicePay.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _invoicePayment = jsonObject.data;
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

  Future<void> postAddReceiptToInvoice(BuildContext context, String invoiceId, String receiptNumber) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/invoice/add-resi';
      print(url);

      var requestBody = {
        'target_id': invoiceId,
        'resi': receiptNumber,
      };

      http.Response response = await http.post(
        url,
        body: json.encode(requestBody),
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getUserToken(),
        },
      );
      print(response.body);
      print(response.statusCode);

      var jsonObject = PostResInvoicePay.fromJson(jsonDecode(response.body));

      Navigator.pop(context);
      Navigator.pop(context);
      if (response.statusCode == 200) {
        _invoicePayment = jsonObject.data;
        getAgentInvoiceHistories(context);
        getInvoiceDetail(context, invoiceId);
        Fluttertoast.showToast(msg: "Resi berhasil dimasukkan.", backgroundColor: Theme.of(context).primaryColor);
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

  List<RatingProductObject> _listRatingProduct = [];

  List<RatingProductObject> get listRatingProduct => _listRatingProduct;

  Future<void> postProductReview(BuildContext context, String invoiceId) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/invoice-product-rating/store';
      print(url);

      await Future.forEach(_listRatingProduct, (RatingProductObject ratingProduct) async {
        var dio = Dio();
        FormData formData = FormData.fromMap(
          {
            'invoice_product_id': ratingProduct.invoiceProductId,
            'star': ratingProduct.star,
            'description': ratingProduct.description,
            'show_name': ratingProduct.showName == null ? 1 : ratingProduct.showName,
          },
        );

        for (var file in ratingProduct.images) {
          formData.files.addAll([
            MapEntry(
              "image[]",
              MultipartFile.fromFileSync(file.path, filename: file.path.split('/').last),
            )
          ]);
        }
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
        print(response.data);
        print(response.statusCode);

        if (response.statusCode == 201) {
        } else if (response.statusCode == 401) {
          CustomAlertDialog.endOfSession(context);
        } else {
          Fluttertoast.showToast(msg: "Terjadi kesalahan. Error code: ${response.statusCode}", backgroundColor: Theme.of(context).accentColor);
        }
      });
      Navigator.pop(context);
      Navigator.pop(context);
      getInvoiceDetail(context, invoiceId);
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  void clearRatingProductList() {
    _listRatingProduct.clear();
  }

  void addProductInvoiceToRatingProductList(ProductInvoice productInvoice) {
    _listRatingProduct.add(RatingProductObject(
      invoiceProductId: productInvoice.id,
      images: [],
    ));
    notifyListeners();
  }

  void updateStarRatingByInvoiceProductId(String invoiceProductId, int star) {
    _listRatingProduct.forEach((ratingProduct) {
      if (ratingProduct.invoiceProductId == invoiceProductId) {
        ratingProduct.star = star;
      }
    });
  }

  void updateRatingDescriptionByInvoiceProductId(String invoiceProductId, String desc) {
    _listRatingProduct.forEach((ratingProduct) {
      if (ratingProduct.invoiceProductId == invoiceProductId) {
        ratingProduct.description = desc;
      }
    });
  }

  void removeRatingProductImageByInvoiceProductId(String invoiceProductId, int index) {
    _listRatingProduct.forEach((ratingProduct) {
      if (ratingProduct.invoiceProductId == invoiceProductId) {
        ratingProduct.images.removeAt(index);
      }
    });
    notifyListeners();
  }

  void updateIsNameVisibleByInvoiceProductId(String invoiceProductId, bool isNameHidden) {
    _listRatingProduct.forEach((ratingProduct) {
      if (ratingProduct.invoiceProductId == invoiceProductId) {
        ratingProduct.showName = isNameHidden ? 0 : 1;
      }
    });
    notifyListeners();
  }

  bool isAllProductHaveRateAlready() {
    bool result = true;
    for (var ratingProduct in _listRatingProduct) {
      if (ratingProduct.star == null) {
        result = false;
        break;
      }
    }
    return result;
  }

  void filterAssetImageSize(List<Asset> listAssets, List<File> listFileToBeStored) {
    listAssets.forEach((asset) async {
      var path = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      File file = File(path);

      // Check whether fileAsset is more than 2Mb
      print('size: ${file.lengthSync()}');
      if (file.lengthSync() < 2000000) {
        listFileToBeStored.add(File(path));
        String mimeStr = lookupMimeType(path);
        var fileType = mimeStr.split('/');
        print('fileType: $fileType');
      } else {
        Fluttertoast.showToast(msg: "Gambar tidak boleh melebihi 2Mb", backgroundColor: Colors.redAccent);
      }
    });
  }

  Future<void> loadAssetsPicture(int index, String invoiceProductId) async {
    try {
      RatingProductObject _ratingProduct;

      _listRatingProduct.forEach((ratingProduct) {
        if (ratingProduct.invoiceProductId == invoiceProductId) {
          _ratingProduct = ratingProduct;
        }
      });

      List<Asset> _listAssets = List<Asset>();

      _listAssets = await MultiImagePicker.pickImages(
        maxImages: 4 - _ratingProduct.images.length,
        enableCamera: true,
      );

      filterAssetImageSize(_listAssets, _ratingProduct.images);
    } on PlatformException catch (e) {
      print(e.message);
    }
    notifyListeners();
  }
}
