import 'package:flutter/material.dart';

class ProviderToko with ChangeNotifier {
  bool _isAlreadyHaveToko = false;

  bool get isAlreadyHaveToko => _isAlreadyHaveToko;

  void setIsAlreadyHaveToko(bool value) {
    _isAlreadyHaveToko = value;
    notifyListeners();
  }
}
