import 'dart:convert';
import 'package:arcade/utils/colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DynamicTheming with ChangeNotifier {
  static const dynamicThemeKey = 'dynamic_theme';

  DynamicThemingData? themeData;

  DynamicTheming() {
    init();
  }

  Future<void> init() async {
    const theme = DynamicThemingData(
      primaryColor: AppColors.engineeringOrange,
      secondaryColor: AppColors.poppy,
    );
    refreshTheme(theme);
  }

  void setNewTheme(DynamicThemingData newTheme) {
    debugPrint(newTheme.toString());
    if (themeData != newTheme) {
      refreshTheme(newTheme);
    }
  }

  void refreshTheme(DynamicThemingData theme) {
    themeData = theme;
    notifyListeners();
  }

  void clearTheme() async {
    if (themeData != null) {
      themeData = null;
      notifyListeners();
    }
  }
}

class DynamicThemingData extends Equatable {
  final Color? primaryColor;
  final Color? secondaryColor;

  const DynamicThemingData({
    this.primaryColor,
    this.secondaryColor,
  });

  @override
  List<Object?> get props => [primaryColor, secondaryColor];

  @override
  String toString() => '$primaryColor, $secondaryColor';
}
