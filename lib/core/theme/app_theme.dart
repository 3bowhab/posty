import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posty/core/extensions/responsive_size_extension.dart';
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
    textTheme: GoogleFonts.cairoTextTheme(ThemeData.light().textTheme),

    colorScheme: const ColorScheme.light(
      primary: AppColors.firstColorAlt,
      secondary: AppColors.firstColor,
      surface: AppColors.bodyColor,
      surfaceContainer: AppColors.containerColor,
      onSurface: AppColors.firstColorDark,
      onSurfaceVariant: AppColors.textColor,
      onPrimary: AppColors.whiteColor,
      onSecondary: AppColors.firstColorDark,
      onSecondaryContainer: AppColors.bodyColorDark,
      error: AppColors.red,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bodyColor,
      foregroundColor: AppColors.bodyColorDark,
      elevation: 0,
      centerTitle: true,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
    ),

    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: AppColors.inputBackground,
      prefixIconColor: AppColors.inputBorder,
      suffixIconColor: AppColors.inputBorder,
      hintStyle: TextStyle(color: AppColors.textColor),
      labelStyle: TextStyle(color: AppColors.textColor),
      floatingLabelStyle: TextStyle(color: AppColors.firstColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.firstColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.red),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.firstColor,
        foregroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: Size(double.infinity, 48.height),
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.containerColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  // Dark Theme
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bodyColorDark,
    textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),

    colorScheme: const ColorScheme.dark(
      primary: AppColors.firstColor,
      secondary: AppColors.firstColorAlt,
      surface: AppColors.bodyColorDark,
      surfaceContainer: AppColors.containerColorDark,
      onSurface: AppColors.titleColor,
      onSurfaceVariant: AppColors.textColor,
      onPrimary: AppColors.bodyColorDark,
      onSecondary: AppColors.firstColor,
      onSecondaryContainer: AppColors.whiteColor,
      error: AppColors.red,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bodyColorDark,
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
    ),

    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: AppColors.inputBackgroundDark,
      prefixIconColor: AppColors.inputBorder,
      suffixIconColor: AppColors.inputBorder,
      hintStyle: TextStyle(color: AppColors.textColor),
      labelStyle: TextStyle(color: AppColors.textColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.firstColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.red),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.firstColor,
        foregroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: Size(double.infinity, 48.height),
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.containerColorDark,
      surfaceTintColor: AppColors.whiteColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
