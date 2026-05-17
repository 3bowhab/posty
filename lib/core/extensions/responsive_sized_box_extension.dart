import 'package:flutter/material.dart';
import '../responsive/responsive_config.dart';

extension ResponsiveSizedBoxExtension on num {
  Widget get verticalSizedBox =>
      SizedBox(height: this * ResponsiveConfig.heightRatio);

  Widget get horizontalSizedBox =>
      SizedBox(width: this * ResponsiveConfig.widthRatio);
}
