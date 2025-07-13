import 'package:flutter/material.dart';

class ScreenUtil {
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getBlockSize(BuildContext context) {
    return getWidth(context) / 100;
  }

  static double getBlockHeight(BuildContext context) {
    return getHeight(context) / 100;
  }

  static double getAspectRatio(BuildContext context) {
    return getWidth(context) / getHeight(context);
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static double getPaddingTop(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getPaddingBottom(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }
}
