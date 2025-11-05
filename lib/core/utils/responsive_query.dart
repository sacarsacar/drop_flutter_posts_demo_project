import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenHelper {
  final BuildContext context;
  final double screenWidth;

  ScreenHelper(this.context) : screenWidth = MediaQuery.of(context).size.width;

  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;

  double get paddingHorizontal => isMobile ? 20.w : (isTablet ? 40 : 60);
  double get paddingVertical => 20.h;
  double get titleFontSize => isMobile ? 24.sp : (isTablet ? 28 : 30);
  double get spacing => isMobile ? 20.h : (isTablet ? 30 : 30);
  double get maxWidth => isMobile ? double.infinity : (isTablet ? 500 : 600);
}
