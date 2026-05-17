import 'package:flutter/material.dart';
import 'package:posty/core/theme/app_colors.dart';

/// | NAME           | SIZE |  WEIGHT |  SPACING |             |
/// |----------------|------|---------|----------|-------------|
/// | displayLarge   | 96.0 | light   | -1.5     |             |
/// | displayMedium  | 60.0 | light   | -0.5     |             |
/// | displaySmall   | 48.0 | regular |  0.0     |             |
/// | headlineMedium | 34.0 | regular |  0.25    |             |
/// | headlineSmall  | 24.0 | regular |  0.0     |             |
/// | titleLarge     | 20.0 | medium  |  0.15    |             |
/// | titleMedium    | 16.0 | regular |  0.15    |             |
/// | titleSmall     | 14.0 | medium  |  0.1     |             |
/// | bodyLarge      | 16.0 | regular |  0.5     |             |
/// | bodyMedium     | 14.0 | regular |  0.25    |             |
/// | bodySmall      | 12.0 | regular |  0.4     |             |
/// | labelLarge     | 14.0 | medium  |  1.25    |             |
/// | labelSmall     | 10.0 | regular |  1.5     |             |
///
///  [w100]: Thin, the thinnest font weight.
///
///  [w200]: Extra light.
///
///  [w300]: Light.
///
///  [w400]: Normal. The constant [FontWeight.normal] is an alias for this value.
///
///  [w500]: Medium.
///
///  [w600]: Semi-bold.
///
///  [w700]: Bold. The constant [FontWeight.bold] is an alias for this value.
///
///  [w800]: Extra-bold.
///
///  [w900]: Black, the thickest font weight.

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.bodyColor,
  );


  // Dark Theme
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bodyColorDark,
  );
}
