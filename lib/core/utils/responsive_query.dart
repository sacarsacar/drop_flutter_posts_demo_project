import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenHelper {
  final BuildContext context;
  final double screenWidth;

  ScreenHelper(this.context) : screenWidth = MediaQuery.of(context).size.width;

  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;

  double get paddingAllEdgeInsets => isMobile ? 10.w : (isTablet ? 10 : 10);
  double get titleFontSize => isMobile ? 24.sp : (isTablet ? 28 : 30);
  double get spacing => isMobile ? 15.h : (isTablet ? 15 : 15);
  double get maxWidth => isMobile ? double.infinity : (isTablet ? 500 : 600);

  //  post cards query:
  double get postcardimageWidth => isMobile ? 120.w : (isTablet ? 130 : 140);
}
