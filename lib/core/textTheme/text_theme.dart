import 'package:denomination/config/colors.dart';
import 'package:flutter/material.dart';

TextStyle customTextStyle({
  required double fontSize,
  FontWeight? fontWeight,
  Color color = AppColors.textcolor,
  FontStyle? fontStyle,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    // fontFamily: "CircularStd",
  );
}
