import 'package:flutter/cupertino.dart';

class CellSizeController extends ChangeNotifier {
  double cellHeight;
  void onChanged(Size size) {
    if (cellHeight == null) {
      cellHeight = size.height;
      notifyListeners();
    }
  }
}
