import 'dart:ffi';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../extensions/colors.dart';
import '../../extensions/style.dart';
import '../../model/post_model.dart';

Widget noListFound({
  required String text,
}) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style:
              fontRegularStyle(fontSize: 16, color: ColorResources.whiteColor),
        ),
      ],
    ),
  );
}


Widget commonIconWidget(
    {required IconData icon, required, required Function() onTap,required PostData model,
required int index,required Color color}) {
  return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        color: color,
      ).paddingOnly(right: 5));
}
