import 'package:flutter/material.dart';

class ProviderHistories with ChangeNotifier {
  int _selectedStagePenjualanIndex = 0;

  int get selectedStagePenjualanIndex => _selectedStagePenjualanIndex;

  void setSelectedStagePenjualanIndex(int index) {
    _selectedStagePenjualanIndex = index;
    notifyListeners();
  }
}
