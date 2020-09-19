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

  static setUserToken(String value) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'user-token', value: value);
  }

  static deleteUserToken() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'user-token');
  }

  static getUserToken() async {
    final storage = new FlutterSecureStorage();
    return await storage.read(key: 'user-token');
  }
}
