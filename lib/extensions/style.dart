import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

TextStyle fontRegularStyle({Color? color, double? fontSize, TextDecoration? decoration}) {
  return GoogleFonts.montserrat(
    color: color,
    fontSize: fontSize,
    decoration: decoration
  );
}

TextStyle comTextStyle(
    {Color? color, required double fontSize, required FontWeight fontWeight}) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Noto_Sans_JP',
      fontWeight: fontWeight,
      color: color);
}

TextStyle navBtnTextStyle() {
  return TextStyle(
      fontSize: 18,
      fontFamily: 'Noto_Sans_JP',
      fontWeight: FontWeight.w700,
      color: ColorResources.whiteColor);
}


TextStyle fontMediumStyle({Color? color, double? fontSize, TextDecoration? decoration}) {
  return GoogleFonts.montserrat(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      decoration: decoration
  );
}

TextStyle fontSemiBoldStyle({Color? color, double? fontSize, TextDecoration? decoration}) {
  return GoogleFonts.montserrat(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
      decoration: decoration
  );
}