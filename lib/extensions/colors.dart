

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorResources {
//Navigation Color
  static Color primary = const Color(0xff0071B8);
  static Color secondary = const Color(0xff437FFF);
  static Color darkBlue = const Color(0xff19499A);
  static Color darkBlueColor = const Color(0xff3163D4);
  static Color redColor = const Color(0xffff4d67);
  static Color grayColor = Get.isPlatformDarkMode
      ? const Color(0xff828282)
      : const Color(0xffE6E6E6);
  static Color borderColor = const Color(0xffB3B3B3);



  static Color lightGreyColor = Get.isPlatformDarkMode
      ? const Color(0xffE6E6E6)
      : const Color(0x80e6e6e6);

  static Color whiteColor = const Color(0xffffffff);
  static Color darkRedColor = const Color(0xffEE3033);
  static Color darkGreenColor = const Color(0xff27AE60);
  static Color textColor = const Color(0xff000000);
  static Color boxColor = const Color(0xffF4F7FF);
  static Color lightTextColor = const Color(0xff666666);
  static Color grey4Color = const Color(0xffBDBDBD);
  static Color grey5Color =const Color(0xffD1D1D1);
  static Color btnColor = const Color(0xffFBFBFB);
  static Color blackColor = const Color(0xff000000);
  static Color grey3 = const Color(0xff828282);
  static Color lightGreyBorderColor = const Color(0xffD9D9D9);
  static Color grey4 = const Color(0xffE8E8E8);
  static Color grey5 = const Color(0xffE0E0E0);
  static Color crossBackground = const Color(0xffF8F8F8);
  static Color sparkColor = const Color(0xffF8AD36);
  static Color greenColor = const Color(0xff229E3D);

  static Color lightBlueColor = const Color(0x1a437FFF);
  static Color lightRedColor = const Color(0xffFFF1EC);
  static Color lightGreenColor = const Color(0xffE9F5EC);

  static Color blackWhite() {
    return Get.isPlatformDarkMode ? Colors.white : Colors.black;
  }

  static Color greyWhite() {
    return Get.isPlatformDarkMode ? Colors.white : const Color(0xff5C5F66);
  }

  static Color whiteBlack() {
    return Get.isPlatformDarkMode ? Colors.black : Colors.white;
  }

  static Color selectedChipChoiceColor() {
    return Get.isPlatformDarkMode ? lightBlueColor : secondary;
  }
  static Color unselectedChipChoiceColor() {
    return Get.isPlatformDarkMode ? whiteColor : grey3;
  }

  static Color searchFieldBackground() {
    return Get.isPlatformDarkMode
        ? blackColor
        : const Color(0xffEEF3F9);
  }

  static Color searchFieldBorder = const Color(0xffEEF3F9);



  static Gradient appGradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[Colors.black, Colors.blue]);

  static Gradient borderGradient = const LinearGradient(
    colors:  <Color>[
      Color(0xff03c4cb),Color(0xFF0044D7) ],
  );

  // static Gradient userImageGradient({required int count}) {
  //   Gradient borderGradient = const LinearGradient(
  //     colors: <Color>[Color(0xffCD7F32), Color(0xffFFC58C), Color(0xffFFC994), Color(0xffCD7F32)],
  //   );
  //
  //   // try{
  //   //   if(count >= int.parse(dashboardController.getGeneralSettingValue(generalKey: goldAchievementCountKey))){
  //   //     borderGradient = const LinearGradient(
  //   //       colors: <Color>[Color(0xffB8922F), Color(0xffF7EF8A), Color(0xffD1AB46), Color(0xffDDB44A)],
  //   //     );
  //   //   }else if(count >= int.parse(dashboardController.getGeneralSettingValue(generalKey: silverAchievementCountKey))){
  //   //     borderGradient = const LinearGradient(
  //   //       colors: <Color>[Color(0xffC0C0C0), Color(0xffFFFFFF), Color(0xffC0C0C0)],
  //   //     );
  //   //   }
  //   // }catch(e){
  //   //   log(e.toString());
  //   // }
  //
  //
  //   return borderGradient;
  // }
}
