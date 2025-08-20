import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'font_manager.dart';




TextStyle _getTextStyle(double fontSize, Color color,  double letterSpacing, FontWeight fontWeight,) {
  return TextStyle(fontSize: fontSize, color: color, letterSpacing: letterSpacing, fontWeight: fontWeight,fontFamily: FontConstants.fontFamily);
}


TextStyle getRFStyle({required Color color, required double fontSize}) {
  return _getTextStyle(fontSize,color,0.2.w,FontWeight.w400);
}

TextStyle getBFStyle({required Color color, required double fontSize}) {
  return _getTextStyle(fontSize, color, 0.2.w, FontWeight.w700);
}

TextStyle getMFStyle({required Color color, required double fontSize}) {
  return _getTextStyle(fontSize, color, 0.2.w, FontWeight.w500);
}

TextStyle getSFStyle({required Color color, required double fontSize,}) {
  return _getTextStyle(fontSize, color, 0.2.w, FontWeight.w700);
}

