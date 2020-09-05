import 'package:flutter/material.dart';

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
}
