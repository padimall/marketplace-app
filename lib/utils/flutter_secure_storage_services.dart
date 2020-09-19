import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageServices {
  static setDevToken(String value) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'dev-token', value: value);
  }

  static getDevToken() async {
    final storage = new FlutterSecureStorage();
    return await storage.read(key: 'dev-token');
  }
}
