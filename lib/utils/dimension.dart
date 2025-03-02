import 'package:flutter/material.dart';

class Dimension with ChangeNotifier {
  late double screenHeight;
  late double screenWidth;

  final double height = 825.45;
  final double width = 392.73;

  Dimension(this.screenHeight, this.screenWidth);

  void updateDimensions(double newHeight, double newWidth) {
    screenHeight = newHeight;
    screenWidth = newWidth;
    notifyListeners();
  }

  double getHeight(double h) {
    return screenHeight / (height / h);
  }

  double getWidth(double w) {
    return screenWidth / (width / w);
  }
}
