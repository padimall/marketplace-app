import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:padimall_app/models/post_show_product_categories.dart';
import 'package:padimall_app/models/post_show_products.dart';
import 'package:padimall_app/utils/custom_alert_dialog.dart';
import 'package:padimall_app/utils/flutter_secure_storage_services.dart';
import '../utils/global.dart' as global;

class ProviderProduct with ChangeNotifier {
  List<Product> _listProduct = [];

  List<Product> get listProduct => _listProduct;

  Future<void> getProducts() async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/product/limit';

      var requestBody = {
        'limit': 30,
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
      print(url);
      print(response.body);
      var jsonObject = PostResShowProducts.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        _listProduct.clear();
        _listProduct.addAll(jsonObject.data);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  List<File> _listProductImage = [];

  List<File> get listProductImage => _listProductImage;

  Future<void> loadAssetsPicture(int index) async {
    try {
//      _listProductImage.clear();
      List<Asset> _listAssets = List<Asset>();
      _listAssets = await MultiImagePicker.pickImages(
        maxImages: 4 - _listProductImage.length,
        enableCamera: false,
      );

      _listAssets.forEach((asset) async {
        var path = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
        _listProductImage.add(File(path));
        print(path);
        String mimeStr = lookupMimeType(path);
        var fileType = mimeStr.split('/');
        print('fileType: ${fileType}');
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
    notifyListeners();
  }

  Future<File> getSingleImage(BuildContext context, ImageSource imageSource) async {
    var imageSelected;
    var image = await ImagePicker.pickImage(source: imageSource);

    if (image != null) {
      var cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
        compressQuality: 30,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.png,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Theme.of(context).primaryColor,
          toolbarTitle: "Crop your image",
        ),
      );

      imageSelected = cropped;
      _listProductImage.clear();
      _listProductImage.add(imageSelected);
      print('image: ${imageSelected.path}');
      notifyListeners();
      return imageSelected;
    }
  }

  Future<void> addProduct(BuildContext context, TextEditingController name, TextEditingController price, TextEditingController weight,
      TextEditingController desc, String productCategoryId, TextEditingController stock, TextEditingController minOrder) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/product/store';

      List<MultipartFile> _imageList = [];
      _listProductImage.forEach((fileProduct) {
        var _pictureFilename = fileProduct.path.split('/').last;
        print('pic file name: ${_pictureFilename}');
        var multipartFile = MultipartFile.fromFileSync(fileProduct.path, filename: _pictureFilename);
        _imageList.add(multipartFile);
        print('sus ko');
      });

      var dio = Dio();
      FormData formData = FormData.fromMap(
        {
          'name': name.text,
          'price': price.text.replaceAll('.', ''),
          'weight': weight.text.replaceAll('.', ''),
          'description': desc.text,
          'category': productCategoryId,
          'stock': stock.text.replaceAll('.', ''),
          'status': "1",
          'min_order': minOrder.text.replaceAll('.', ''),
        },
      );
      for (var file in _listProductImage) {
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

      print(url);
      print(response.data);

      Navigator.pop(context);
      if (response.statusCode == 201) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Produk berhasil ditambahkan.', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
        getSupplierProduct();
      }
    } on DioError catch (dioError) {
      // Something happened in setting up or sending the request that triggered an Error
      print(dioError.response);
    } finally {
      notifyListeners();
    }
  }

  List<Product> _listSupplierProducts = [];

  List<Product> get listSupplierProducts => _listSupplierProducts;

  Future<void> getSupplierProduct() async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/product/supplier';

      http.Response response = await http.post(
        url,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getUserToken(),
        },
      );
      print(url);
      print(response.body);
      var jsonObject = PostResShowProducts.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        if (jsonObject.status == 1) {
          _listSupplierProducts.clear();
          _listSupplierProducts = jsonObject.data;
        } else if (jsonObject.status == 0){

        }
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> getAgentProduct() async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/product/agent';

      http.Response response = await http.post(
        url,
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getUserToken(),
        },
      );
      print(url);
      print(response.body);
      var jsonObject = PostResShowProducts.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        if (jsonObject.status == 1) {
//          _listSupplierProducts.clear();
//          _listSupplierProducts = jsonObject.data;
        } else if (jsonObject.status == 0){

        }
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  void removeListProductImage(int index) {
    _listProductImage.removeAt(index);
    notifyListeners();
  }

  void resetListProductImage() {
    _listProductImage.clear();
    notifyListeners();
  }

  Future<void> updateProduct(BuildContext context, String productId, TextEditingController name, TextEditingController price, TextEditingController weight,
      TextEditingController desc, ProductCategory productCategory, TextEditingController stock, TextEditingController minOrder) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/product/update';

      List<MultipartFile> _imageList = [];
      _listProductImage.forEach((fileProduct) {
        var _pictureFilename = fileProduct.path.split('/').last;
        print('pic file name: ${_pictureFilename}');
        var multipartFile = MultipartFile.fromFileSync(fileProduct.path, filename: _pictureFilename);
        _imageList.add(multipartFile);
        print('sus ko');
      });

      var dio = Dio();
      FormData formData = FormData.fromMap(
        {
          'target_id': productId,
          'name': name.text,
          'price': price.text.replaceAll('.', ''),
          'weight': weight.text.replaceAll('.', ''),
          'description': desc.text,
          'category': productCategory.id,
          'stock': stock.text.replaceAll('.', ''),
          'status': "1",
          'min_order': minOrder.text.replaceAll('.', ''),
        },
      );
//      for (var file in _listProductImage) {
//        formData.files.addAll([
//          MapEntry(
//            "image[]",
//            MultipartFile.fromFileSync(file.path, filename: file.path.split('/').last),
//          )
//        ]);
//      }
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

      print(url);
      print(response.data);
      print(response.statusCode);

      Navigator.pop(context);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Produk anda berhasil diperbaharui.', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
        getSupplierProduct();
      }
    } on DioError catch (dioError) {
      // Something happened in setting up or sending the request that triggered an Error
      print(dioError.response);
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteProduct(BuildContext context, Product product) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/product/delete';

      var requestBody = {
        'target_id': product.id,
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
      print(url);
      print(response.body);
      Navigator.pop(context);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Produk berhasil dihapus.', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).accentColor);
        Navigator.pop(context);
        getSupplierProduct();
      }
    } catch (e) {
      print(e.toString());
    } finally {}
  }
}
