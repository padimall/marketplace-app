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
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:mime/mime.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:padimall_app/models/post_show_product_categories.dart';
import 'package:padimall_app/models/post_show_product_detail.dart';
import 'package:padimall_app/models/post_show_products.dart';
import 'package:padimall_app/models/product_main_category.dart';
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


  Product _productDetail = Product(
    images: [],
  );

  Product get productDetail => _productDetail;

  Future<void> getProductDetail(BuildContext context, String productId) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/product/detail';

      var requestBody = {
        'target_id': productId,
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
      var jsonObject = PostResShowProductDetail.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        if (jsonObject.status == 1) {
          _productDetail = jsonObject.data;
        }
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
      List<Asset> _listAssets = List<Asset>();
      _listAssets = await MultiImagePicker.pickImages(
        maxImages: 4 - _listProductImage.length,
        enableCamera: true,
      );

      _listAssets.forEach((asset) async {
        var path = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
        File file = File(path);
        print('size: ${file.lengthSync()}');
        if (file.lengthSync() < 2000000) {
          _listProductImage.add(File(path));
          String mimeStr = lookupMimeType(path);
          var fileType = mimeStr.split('/');
          print('fileType: ${fileType}');
        } else {
          Fluttertoast.showToast(msg: "Gambar tidak boleh melebihi 2Mb", backgroundColor: Colors.redAccent);
        }
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
      print(response.statusCode);
      print(response.data);

      Navigator.pop(context);
      if (response.statusCode == 201) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Produk berhasil ditambahkan.', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
        getAgentProduct();
        getSupplierProduct();
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: 'Terjadi kesalahan. (${response.statusCode})', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
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
        } else if (jsonObject.status == 0) {
          _listSupplierProducts.clear();
        }
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> getSupplierOfAgentProduct(String supplierId) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/product/my-supplier';

      var requestBody = {
        'target_id': supplierId,
      };

      http.Response response = await http.post(url,
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getUserToken(),
          },
          body: json.encode(requestBody));
      print(url);
      print(response.body);
      var jsonObject = PostResShowProducts.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        if (jsonObject.status == 1) {
          _listSupplierProducts.clear();
          _listSupplierProducts = jsonObject.data;
        } else if (jsonObject.status == 0) {
          _listSupplierProducts.clear();
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
        _listSupplierProducts.clear();
        if (jsonObject.status == 1) {
          _listSupplierProducts = jsonObject.data;
        } else if (jsonObject.status == 0) {
          // No item found
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

  List<String> _listImageInTrash = [];

  List<String> get listImageInTrash => _listImageInTrash;

  void addImageProductToTemporaryTrash(String imageId) {
    _listImageInTrash.add(imageId);
    notifyListeners();
  }

  void resetListProductInTemporaryTrash() {
    _listImageInTrash.clear();
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

      // Delete image in listImageInTrash
      _listImageInTrash.forEach((imageIdInTrash) async {
        await deleteProductImage(imageIdInTrash);
      });

      // Upload image in listProductImage
      await addProductImage(productId);

      Navigator.pop(context);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Produk anda berhasil diperbaharui.', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).primaryColor);
        getSupplierProduct();
        getAgentProduct();
      }
    } on DioError catch (dioError) {
      // Something happened in setting up or sending the request that triggered an Error
      print(dioError.response);
    } finally {
      notifyListeners();
    }
  }

  Future<void> addProductImage(String productId) async {
    var url = '${global.API_URL_PREFIX}/api/v1/product-image/store';
    var dio = Dio();
    FormData formData = FormData.fromMap(
      {
        'product_id': productId,
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

    print('new pic: ${response.data}');
  }

  Future<void> deleteProductImage(String imageId) async {
    var url = '${global.API_URL_PREFIX}/api/v1/product-image/delete';

    var requestBody = {
      'target_id': imageId,
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
        getAgentProduct();
      }
    } catch (e) {
      print(e.toString());
    } finally {}
  }

  Future<void> updateStatusProduct(BuildContext context, Product product, String supplierId) async {
    try {
      CustomAlertDialog.loading(context);
      var url = '${global.API_URL_PREFIX}/api/v1/product/update-status';

      var requestBody = {
        'target_id': product.id,
        'status': product.status == '1' ? 0 : 1,
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
        Fluttertoast.showToast(msg: 'Status produk berhasil diperbaharui.', toastLength: Toast.LENGTH_LONG, backgroundColor: Theme.of(context).accentColor);
        getSupplierOfAgentProduct(supplierId);
      }
    } catch (e) {
      print(e.toString());
    } finally {}
  }

  List<Product> _listProductByMainCategory = [];

  List<Product> get listProductByMainCategory => _listProductByMainCategory;

  Future<void> getProductByMainCategory(BuildContext context, ProductMainCategory mainCategory) async {
    print(mainCategory.id);
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/product/main-category';

      var requestBody = {
        'target_id': mainCategory.id,
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

      var jsonObject = PostResShowProducts.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        _listProductByMainCategory.clear();
        if (jsonObject.status == 1) {
          _listProductByMainCategory.addAll(jsonObject.data);
        }
        print('item: ${_listProductByMainCategory.length}');
      }
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }

  List<Product> _listOfSearchedProduct = [];

  List<Product> get listOfSearchedProduct => _listOfSearchedProduct;

  Future<void> searchProductByName(String name) async {
    try {
      var url = '${global.API_URL_PREFIX}/api/v1/product/search';

      var requestBody = {
        'name': name,
      };

      http.Response response = await http.post(url,
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + await FlutterSecureStorageServices.getUserToken(),
          },
          body: json.encode(requestBody));
      print(url);
      print(response.body);
      var jsonObject = PostResShowProducts.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        if (jsonObject.status == 1) {
          _listOfSearchedProduct.clear();
          _listOfSearchedProduct = jsonObject.data;
        } else if (jsonObject.status == 0) {
          _listOfSearchedProduct.clear();
        }
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
