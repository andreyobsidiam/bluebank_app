import 'package:flutter/material.dart';

extension TextStyleExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ConstantsExtensions on BuildContext {
  double get sm => 8.0;
  double get sl => 12.0;
  double get md => 16.0;
  double get lg => 24.0;
  double get xl => 32.0;
  double get xxl => 40.0;
  double get x2l => 48.0;
  double get x3l => 56.0;
  double get x4l => 64.0;
}
