import 'package:posty/core/responsive/responsive_config.dart';

extension ResponsiveSize on num {
  double get width => this * ResponsiveConfig.widthRatio;
  double get height => this * ResponsiveConfig.heightRatio;
}
