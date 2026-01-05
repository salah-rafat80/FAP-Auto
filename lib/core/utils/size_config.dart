import 'package:flutter/material.dart';

/// Helper class for responsive sizing using MediaQuery
class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;

  /// Initialize screen dimensions - call this in build method
  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
  }

  /// Get responsive width based on percentage (0-100)
  static double w(double percentage) => blockWidth * percentage;

  /// Get responsive height based on percentage (0-100)
  static double h(double percentage) => blockHeight * percentage;

  /// Get responsive font size - محسّن للأجهزة المختلفة
  static double sp(double size) {
    // معاملات مُحسَّنة لقراءة أوضح على مختلف الأجهزة
    final double scaleFactor = screenWidth < 360 ? 0.50 :
                               screenWidth < 400 ? 0.55 :
                               screenWidth < 600 ? 0.60 :
                               screenWidth < 800 ? 0.65 : 0.70;

    return blockWidth * size * scaleFactor;
  }

  /// Get responsive icon size
  static double iconSize(double baseSize) {
    return w(baseSize).clamp(20.0, 100.0);
  }
}
