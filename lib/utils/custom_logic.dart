import 'package:padimall_app/utils/flutter_secure_storage_services.dart';

class CustomLogic {
  static Future<bool> isUserTokenExist() async {
    var _token = await FlutterSecureStorageServices.getUserToken();
    if (_token != null) {
      return true;
    }
    return false;
  }
}
