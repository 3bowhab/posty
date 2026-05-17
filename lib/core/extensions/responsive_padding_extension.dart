import 'package:flutter/material.dart';
import '../responsive/responsive_config.dart';

extension ResponsivePadding on num {
  // Individual side padding
  EdgeInsets get rightPadding =>
      EdgeInsets.only(right: this * ResponsiveConfig.widthRatio);

  EdgeInsets get leftPadding =>
      EdgeInsets.only(left: this * ResponsiveConfig.widthRatio);

  EdgeInsets get topPadding =>
      EdgeInsets.only(top: this * ResponsiveConfig.heightRatio);

  EdgeInsets get bottomPadding =>
      EdgeInsets.only(bottom: this * ResponsiveConfig.heightRatio);


  // Combined padding extensions
  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: this * ResponsiveConfig.widthRatio);

  EdgeInsets get verticalPadding =>
      EdgeInsets.symmetric(vertical: this * ResponsiveConfig.heightRatio);


  // All sides padding
  EdgeInsets get allPadding => EdgeInsets.fromLTRB(
    this * ResponsiveConfig.widthRatio,
    this * ResponsiveConfig.heightRatio,
    this * ResponsiveConfig.widthRatio,
    this * ResponsiveConfig.heightRatio,
  );
}