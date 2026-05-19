import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posty/core/extensions/responsive_size_extension.dart';
import 'package:posty/core/theme/app_colors.dart';

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
