import "package:flutter/material.dart";

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;
  List<dynamic> _shoeSizes = [];
  List<String> _sizes = [];

  int get activePage => _activePage;
  List<dynamic> get shoeSizes => _shoeSizes;
  List<String> get sizes => _sizes;

  set activePage(int index) {
    _activePage = index;
    notifyListeners();
  }

  set shoeSizes(List<dynamic> newSizes) {
    _shoeSizes = newSizes;
    notifyListeners();
  }

  set sizes(List<String> newSizes){
    _sizes = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _shoeSizes.length; i++) {
      if (i == index) {
        _shoeSizes[i]["isSelected"] = !_shoeSizes[i]["isSelected"];
      }
    }
    notifyListeners();
  }
}
